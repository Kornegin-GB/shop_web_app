import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_card_widget.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ShoppingCartCardWidget(products: products, index: index);
      },
    );
  }
}
