import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/models/favourites_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';

/// Класс рисует страницу одного товара
class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavourite = false;

  @override
  void initState() {
    FavouritesProductModel()
        .favouriteProductExists(widget.product.productId)
        .then((value) {
      isFavourite = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      children: [
        const Padding(padding: EdgeInsets.all(3)),
        Image(image: AssetImage('assets/images/${widget.product.imgProduct}')),
        const Padding(padding: EdgeInsets.all(10)),
        Text(
          'Цена: ${widget.product.priceProduct.toString()} р.',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Text(widget.product.descriptionProduct, textAlign: TextAlign.justify),
        const Padding(padding: EdgeInsets.all(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                ShoppingCartModel().addProduct(widget.product);
              },
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                minimumSize: const Size(280, 60),
                textStyle: const TextStyle(
                  fontSize: 22,
                ),
              ),
              child: const Text('Add to cart'),
            ),
            Consumer<FavouritesProductModel>(
              builder: (context, value, child) => (isFavourite)
                  ? IconButton(
                      onPressed: () {
                        isFavourite = false;
                        value.deleteFavouriteProduct(widget.product.productId);
                        setState(() {});
                      },
                      icon: const Icon(Icons.favorite,
                          size: 38, color: Colors.blueGrey),
                    )
                  : IconButton(
                      onPressed: () {
                        isFavourite = true;
                        value.addFavouriteProduct(widget.product);
                        setState(() {});
                      },
                      icon: const Icon(Icons.favorite_border,
                          size: 38, color: Colors.blueGrey),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
