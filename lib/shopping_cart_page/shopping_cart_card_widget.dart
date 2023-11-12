import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/models/cart_product_model.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';

/// Формирование отображения карточки товара на странице
class ShoppingCartCardWidget extends StatelessWidget {
  const ShoppingCartCardWidget({
    super.key,
    required this.product,
  });

  final CartProductModel product;

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
                  Consumer<ShoppingCartModel>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18),
                          onPressed: () {
                            value.quantityDown(product);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Text(
                          '${value.getQuantity(product)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () {
                            value.quantityUp(product);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                ShoppingCartModel().deleteProduct(product);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.blueGrey,
              )),
        ],
      ),
    );
  }
}
