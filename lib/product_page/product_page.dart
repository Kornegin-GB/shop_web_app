import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/add_shopping_cart.dart';
import 'package:shop_web_app/adding_products/product.dart';

/// Класс рисует страницу одного товара
class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      children: [
        const Padding(padding: EdgeInsets.all(3)),
        Image(image: AssetImage('assets/images/${product.imgProduct}')),
        const Padding(padding: EdgeInsets.all(10)),
        Text(
          'Цена: ${product.priceProduct.toString()} р.',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text(product.descriptionProduct, textAlign: TextAlign.justify),
        const Padding(padding: EdgeInsets.all(20)),
        ElevatedButton(
          onPressed: () {
            AddShoppingCart().setProduct(product);
          },
          style: ElevatedButton.styleFrom(
            elevation: 5.0,
            minimumSize: const Size.square(60),
            textStyle: const TextStyle(
              fontSize: 22,
            ),
          ),
          child: const Text('Добавить в корзину'),
        ),
      ],
    );
  }
}
