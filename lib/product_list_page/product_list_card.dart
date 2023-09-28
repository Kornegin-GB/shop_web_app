import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';

/// Класс рисует карточку товара списка
class ProductListCard extends StatelessWidget {
  const ProductListCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: product);
        },
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
                    Text(
                      product.descriptionProduct,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Text('Цена: ${product.priceProduct.toString()} р.'),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                ShoppingCart().setProduct(product);
              },
              icon: const Icon(
                Icons.add_shopping_cart,
                size: 32,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
