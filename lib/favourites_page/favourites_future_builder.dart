import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/favourites_page/add_favourites_product.dart';
import 'package:shop_web_app/favourites_page/favourites_card.dart';

class FavouritesFutureBuilder extends StatelessWidget {
  const FavouritesFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddFavouritesProduct>(
      builder: (context, value, child) => FutureBuilder(
        future: value.getListFavourite(),
        builder: (context, snapshot) {
          value.getListFavourite();
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final products = snapshot.data as List<Product>;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return FavouritesCard(product: products[index]);
              },
            );
          }
        },
      ),
    );
  }
}
