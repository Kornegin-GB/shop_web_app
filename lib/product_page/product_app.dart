import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/product_page/product_page.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: BuilderAppBar(titleApp: product.nameProduct),
      ),
      body: ProductPage(product: product),
    );
  }
}
