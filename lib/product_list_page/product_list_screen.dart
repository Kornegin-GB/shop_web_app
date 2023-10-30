import 'package:flutter/material.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/loading_list_products.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/product_list_page/product_list_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> products = [];

  Future<void> _loadProductsList() async {
    products = await LoadingListProducts().getProductList();
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
        title: const BuilderAppBar(titleApp: 'Shop web app', withCart: true),
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
