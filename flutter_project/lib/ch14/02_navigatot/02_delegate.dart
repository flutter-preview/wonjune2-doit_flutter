import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouterInformationParser(),
    );
  }
}

class MyRoutePath {
  String? id;
  MyRoutePath.home() : id = null;
  MyRoutePath.detail(this.id);
}

class MyRouterInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.length >= 2) {
      var remaing = uri.pathSegments[1];
      return MyRoutePath.detail(remaing);
    } else {
      return MyRoutePath.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(MyRoutePath configuration) {
    if (configuration.id != null) {
      return RouteInformation(location: '/detail/${configuration.id}');
    } else {
      return const RouteInformation(location: '/');
    }
  }
}

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  String? selectId;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  MyRoutePath? get currentConfiguration {
    if (selectId != null) {
      return MyRoutePath.detail(selectId);
    } else {
      return MyRoutePath.home();
    }
  }

  @override
  Widget build(BuildContext context) {
    throw Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: HomeScreen(_handleOnPressed),
        ),
        if (selectId != null) MaterialPage(child: DetailScreen(selectId)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        selectId = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    if (configuration.id != null) {
      selectId = configuration.id;
    }
  }

  void _handleOnPressed(String id) {
    selectId = id;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onPressed;
  const HomeScreen(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Screen',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () => onPressed('1'),
              child: const Text('go detail with 1'),
            ),
            ElevatedButton(
              onPressed: () => onPressed('2'),
              child: const Text('go detail with 2'),
            ),
          ],
        )),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;
  DetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
            child: Text(
          'Detail Screen$id',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        )),
      ),
    );
  }
}
