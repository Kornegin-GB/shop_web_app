import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';
import 'package:shop_web_app/favourites_page/favourites_db.dart';
import 'package:shop_web_app/favourites_page/favourites_screen.dart';
import 'package:shop_web_app/product_list_page/product_list_screen.dart';
import 'package:shop_web_app/product_page/product_screen.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ShoppingCart()),
          ChangeNotifierProvider(create: (context) => FavoritesDb.db),
          Provider(create: (context) => const ShoppingCartScreen()),
          Provider(create: (context) => const FavouritesScreen()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // brightness: Brightness.dark,
            primarySwatch: Colors.blueGrey,
          ),
          routes: {
            '/product_list': (context) => const ProductListScreen(),
            '/product': (context) => const ProductScreen(),
            '/cart': (context) => const ShoppingCartScreen(),
            '/favourites': (context) => const FavouritesScreen(),
          },
          initialRoute: '/product_list',
        ),
      ),
    );
