import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';

/// Формирование отображения карточки товара на странице
class ShoppingCartCardWidget extends StatelessWidget {
  ShoppingCartCardWidget({
    super.key,
    required this.index,
    required this.product,
  });

  int index;
  Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/${product.imgProduct}'),
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
                    product.nameProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text('Цена: ${product.priceProduct.toString()} р.'),
                  Consumer<ShoppingCart>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () {
                            value.quantityUp(product);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                        ),
                        Text(
                          '${value.products[product]}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          onPressed: () {
                            value.quantityDown(product);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
