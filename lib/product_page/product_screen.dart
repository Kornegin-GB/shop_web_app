import 'package:flutter/material.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/product_page/product_page.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    return Scaffold(
        appBar: AppBar(
          title: BuilderAppBar(titleApp: product.nameProduct, withCart: true),
        ),
        body: ProductPage(product: product));
  }
}
