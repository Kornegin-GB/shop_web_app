import 'package:flutter/material.dart';
import 'package:shop_web_app/product.dart';

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
        title: Text(product.nameProduct),
      ),
      body: ProductPage(product: product),
    );
  }
}

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
      ],
    );
  }
}
