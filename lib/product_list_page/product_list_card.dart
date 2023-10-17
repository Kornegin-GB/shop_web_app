import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';
import 'package:shop_web_app/favourites_page/add_favourites_product.dart';

/// Класс рисует карточку товара списка
class ProductListCard extends StatefulWidget {
  const ProductListCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  late bool isFavourite = false;

  @override
  void initState() {
    AddFavouritesProduct()
        .isNotEmptyFavouriteProduct(widget.product.id)
        .then((value) {
      isFavourite = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: widget.product);
        },
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
                Consumer<AddFavouritesProduct>(
                  builder: (context, value, child) => (isFavourite)
                      ? IconButton(
                          onPressed: () {
                            isFavourite = false;
                            value.deleteFavouriteProduct(widget.product.id);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.blueGrey,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            isFavourite = true;
                            value.addFavouriteProduct(widget.product);
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.blueGrey,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
