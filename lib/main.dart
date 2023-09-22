import 'package:flutter/material.dart';
import 'package:shop_web_app/product_list_page/product_list_app.dart';
import 'package:shop_web_app/product_page/product_app.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_app.dart';

void main() =>
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          // brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/product_list': (context) => const ProductListApp(),
          '/product': (context) => const ProductApp(),
          '/cart': (context) => const ShoppingCartApp(),
        },
        initialRoute: '/product_list',
      ),
    );
