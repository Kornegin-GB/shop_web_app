import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/favourites_page/favourites_card.dart';
import 'package:shop_web_app/favourites_page/favourites_db.dart';

class FavouritesFutureBuilder extends StatelessWidget {
  const FavouritesFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesDb>(
      builder: (context, value, child) => FutureBuilder(
        future: value.showAllProducts(),
        builder: (context, snapshot) {
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
