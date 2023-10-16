import 'package:flutter/material.dart';
import 'package:shop_web_app/favourites_page/favourites_screen.dart';
import 'package:shop_web_app/product_list_page/product_list_screen.dart';

class MainPageApp extends StatefulWidget {
  const MainPageApp({super.key});

  @override
  State<MainPageApp> createState() => _MainPageAppState();
}

class _MainPageAppState extends State<MainPageApp> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pagesApp = <Widget>[
    const ProductListScreen(),
    const FavouritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesApp.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.white,
        onTap: _selectedPage,
      ),
    );
  }
}
