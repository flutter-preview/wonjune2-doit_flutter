import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inherited Test'),
        ),
        body: MyInheritedWidget(TestWidget()),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  int count = 0; //하위 공유 데이터..

  MyInheritedWidget(child, {super.key}) : super(child: child);

  increment() {
    //하위에서 호출 할 함수
    count++;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;

  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
}

class TestSubWidget extends StatelessWidget {
  const TestSubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context)!.count;
    return Container(
      width: 200,
      height: 200,
      color: Colors.yellow,
      child: Center(
        child: Text(
          'SubWidget : $count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

////MyInheritedWidget 의 하위 위젯이다.
//+ StatefulBuilder
class TestWidget extends StatelessWidget {
  TestWidget({super.key}) {
    print('TestWidget constructor..');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      MyInheritedWidget? widget = MyInheritedWidget.of(context);
      int counter = MyInheritedWidget.of(context)!.count;
      Function increment = MyInheritedWidget.of(context)!.increment;
      return Center(
        child: Container(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'TestWidget : $counter',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  child: const Text('increment()'),
                  onPressed: () => setState(() => increment())),
              ElevatedButton(
                  onPressed: () {
                    setState(() => widget!.count++);
                  },
                  child: const Text('count++')),
              const TestSubWidget()
            ],
          ),
        ),
      );
    });
  }
}
