import 'package:flutter/material.dart';
import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:shop_web_app/models/product_model.dart';

///Класс описывает добавление продуктов в избранное (модель избранного)
class FavouritesProductModel extends ChangeNotifier {
  var mainDb = DatabaseApp.db;

  ///Добавление продукта в избранное
  void addFavouriteProduct(ProductModel product) {
    mainDb.insertProduct(product, mainDb.tableFavourite);
    notifyListeners();
  }

  ///Удаление продукта из избранного
  void deleteFavouriteProduct(int id) {
    mainDb.deleteProduct(id, mainDb.tableFavourite);
    notifyListeners();
  }

  ///Получение списка добавленных продуктов в избранное
  Future<List<ProductModel>> getListFavourite() async {
    return await mainDb.getAllFavourites();
  }

  ///Проверить существует ли продукт в избранном
  Future<bool> favouriteProductExists(int id) async {
    return await mainDb.productExists(id);
  }
}
