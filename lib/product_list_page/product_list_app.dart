import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/add_list_product.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/product_list_page/product_list_card.dart';

class ProductListApp extends StatefulWidget {
  const ProductListApp({super.key});

  @override
  State<ProductListApp> createState() => _ProductListAppState();
}

class _ProductListAppState extends State<ProductListApp> {
  List<Product> products = [];

  Future<void> _loadProductsList() async {
    products = await AddListProduct().getProductList();
    setState(() {});
  }

  @override
  void initState() {
    _loadProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BuilderAppBar(titleApp: 'Shop web app'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductListCard(product: products[index]);
        },
      ),
    );
  }
}
