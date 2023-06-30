import 'package:flutter/material.dart';

void main() {
  runApp(const ParentWidget());
}

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    setState(() {
      if (favorited) {
        favoriteCount -= 1;
        favorited = true;
      } else {
        favoriteCount += 1;
        favorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('State Test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconWidget(
              favorited: favorited,
              onChanged: toggleFavorite,
            ),
            ContentWidget(
              favoriteCount: favoriteCount,
            ),
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  final bool favorited;
  final Function onChanged;

  const IconWidget({
    super.key,
    required this.favorited,
    required this.onChanged,
  });

  void _handleTap() {
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        iconSize: 200,
        color: Colors.red,
        icon: (favorited
            ? const Icon(
                Icons.favorite,
              )
            : const Icon(
                Icons.favorite_border,
              )),
        onPressed: _handleTap,
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  const ContentWidget({
    super.key,
    required this.favoriteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text('favoriteCount: $favoriteCount'),
        )
      ],
    );
  }
}
