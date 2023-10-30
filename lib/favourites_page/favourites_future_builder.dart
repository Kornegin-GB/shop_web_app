import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/favourites_page/favourites_card.dart';
import 'package:shop_web_app/models/favourites_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';

class FavouritesFutureBuilder extends StatelessWidget {
  const FavouritesFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProductModel>(
      builder: (context, value, child) => FutureBuilder(
        future: value.getListFavourite(),
        builder: (context, snapshot) {
          value.getListFavourite();
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final products = snapshot.data as List<ProductModel>;
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
