import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/main_page_app.dart';
import 'package:shop_web_app/models/favourites_product_model.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/product_list_page/product_list_screen.dart';
import 'package:shop_web_app/product_page/product_screen.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ShoppingCartModel()),
          ChangeNotifierProvider(create: (context) => FavouritesProductModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.blueGrey,
            ),
          ),
          routes: {
            "/": (context) => const MainPageApp(),
            '/product_list': (context) => const ProductListScreen(),
            '/product': (context) => const ProductScreen(),
            '/cart': (context) => const ShoppingCartScreen(),
          },
          initialRoute: '/',
        ),
      ),
    );
