import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';

class ShoppingCartCardWidget extends StatelessWidget {
  ShoppingCartCardWidget({
    super.key,
    required this.index,
  });

  int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCart>(
      builder: (context, value, child) => Card(
        color: Theme.of(context).colorScheme.background,
        child: Row(
          children: [
            Image(
              image: AssetImage(
                  'assets/images/${value.products.keys.elementAt(index).imgProduct}'),
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
                        value.products.keys.elementAt(index).nameProduct,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                          'Цена: ${value.products.keys.elementAt(index).priceProduct.toString()} р.'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () {
                              value.quantityUp(
                                  value.products.keys.elementAt(index));
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Text(
                            '${value.products[value.products.keys.elementAt(index)]}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: () {
                              value.quantityDown(
                                  value.products.keys.elementAt(index));
                            },
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
