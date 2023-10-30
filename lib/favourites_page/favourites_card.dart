import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/models/favourites_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';

class FavouritesCard extends StatefulWidget {
  const FavouritesCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

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
                  ShoppingCartModel().addProduct(widget.product);
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 32,
                  color: Colors.blueGrey,
                ),
              ),
              Consumer<FavouritesProductModel>(
                builder: (context, value, child) => IconButton(
                  onPressed: () {
                    value.deleteFavouriteProduct(widget.product.productId);
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
