import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_web_app/favourites_page/favourites_screen.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';
import 'package:shop_web_app/product_list_page/product_list_screen.dart';

class MainPageApp extends StatefulWidget {
  const MainPageApp({super.key});

  @override
  State<MainPageApp> createState() => _MainPageAppState();
}

class _MainPageAppState extends State<MainPageApp> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _initStartApp();
    setState(() {});
    super.initState();
  }

  void _initStartApp() async {
    await _loadUser();
    await UserAuthorizationModel().loadAuthenticationUser();
    ShoppingCartModel().loadProduct();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pagesApp = <Widget>[
    const ProductListScreen(),
    const FavouritesScreen()
  ];

  _loadUser() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    var user = sharedUser.getString('email');
    if (user != null) {
      UserAuthorizationModel().changingAuthentication();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAuthorized =
        context.watch<UserAuthorizationModel>().isAuthenticationUser;
    return (isAuthorized)
        ? Scaffold(
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
          )
        : const ProductListScreen();
  }
}
