import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/database_app.dart';

class AddFavouritesProduct extends ChangeNotifier {
  var mainDb = DatabaseApp.db;

  ///Добавление продукта в избранное
  void addFavouriteProduct(Product product) {
    mainDb.insertProduct(product, mainDb.tableFavourite);
    notifyListeners();
  }

  ///Удаление продукта из избранного
  void deleteFavouriteProduct(int id) {
    mainDb.deleteProduct(id, mainDb.tableFavourite);
    notifyListeners();
  }

  ///Получение списка добавленных продуктов в избранное
  Future<List<Product>> getListFavourite() async {
    return await mainDb.showAllFavourites();
  }

  ///Проверить существует ли продукт в избранном
  Future<bool> isNotEmptyFavouriteProduct(int id) async {
    return await mainDb.isNotEmptyProduct(id);
  }
}
