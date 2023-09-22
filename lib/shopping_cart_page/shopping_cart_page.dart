import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';

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
        return Card(
          color: Theme.of(context).colorScheme.background,
          child: Row(
            children: [
              Image(
                image:
                    AssetImage('assets/images/${products[index].imgProduct}'),
                width: 150,
              ),
              const Padding(padding: EdgeInsets.all(5)),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].nameProduct,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                          'Цена: ${products[index].priceProduct.toString()} р.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
