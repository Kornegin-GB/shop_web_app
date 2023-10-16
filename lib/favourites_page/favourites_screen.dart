import 'package:flutter/material.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/favourites_page/favourites_future_builder.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BuilderAppBar(titleApp: 'Favourites', withCart: true),
        ),
        body: const FavouritesFutureBuilder());
  }
}
