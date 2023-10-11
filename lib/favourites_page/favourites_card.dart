import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';
import 'package:shop_web_app/favourites_page/favourites_db.dart';

class FavouritesCard extends StatefulWidget {
  const FavouritesCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<FavouritesCard> createState() => _FavouritesCardState();
}

class _FavouritesCardState extends State<FavouritesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/${widget.product.imgProduct}'),
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
                    widget.product.nameProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                    widget.product.descriptionProduct,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Text('Цена: ${widget.product.priceProduct.toString()} р.'),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  ShoppingCart().setProduct(widget.product);
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 32,
                  color: Colors.blueGrey,
                ),
              ),
              Consumer<FavoritesDb>(
                builder: (context, value, child) => IconButton(
                  onPressed: () {
                    value.deleteProduct(widget.product.id);
                    value.closeDB();
                  },
                  icon: const Icon(Icons.delete, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}