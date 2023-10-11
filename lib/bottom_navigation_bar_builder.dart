import 'package:flutter/material.dart';

class BottomNavigationBarBuilder extends StatefulWidget {
  late int favoritePage;

  BottomNavigationBarBuilder({
    super.key,
    required this.favoritePage,
  });

  @override
  State<BottomNavigationBarBuilder> createState() =>
      _BottomNavigationBarBuilderState();
}

class _BottomNavigationBarBuilderState
    extends State<BottomNavigationBarBuilder> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
      ],
      currentIndex: widget.favoritePage,
      onTap: (int index) {
        setState(() {
          widget.favoritePage = index;
        });
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/product_list');
          case 1:
            Navigator.pushNamed(context, '/favourites');
        }
      },
    );
  }
}
