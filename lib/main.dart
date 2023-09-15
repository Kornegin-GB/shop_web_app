import 'package:flutter/material.dart';
import 'package:shop_web_app/product_app.dart';
import 'package:shop_web_app/product_list_app.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/product_list': (context) => const ProductListApp(),
          '/product': (context) => const ProductApp(),
        },
        initialRoute: '/product_list',
      ),
    );
