import 'package:flutter/material.dart';
import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';

///Класс описывает добавление продуктов в избранное (модель избранного)
class FavouritesProductModel extends ChangeNotifier {
  var mainDb = DatabaseApp.db;

  ProductModel _initProduct(ProductModel product) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    return ProductModel(
        productId: product.productId,
        nameProduct: product.nameProduct,
        descriptionProduct: product.descriptionProduct,
        priceProduct: product.priceProduct,
        imgProduct: product.imgProduct,
        fkUserId: userId);
  }

  ///Добавление [product] в избранное
  void addFavouriteProduct(ProductModel product) {
    mainDb.insertProduct(_initProduct(product), mainDb.tableFavourite);
    notifyListeners();
  }

  ///Удаление продукта из избранного по его [id]
  void deleteFavouriteProduct(int id) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    mainDb.deleteProduct(id, userId!, mainDb.tableFavourite);
    notifyListeners();
  }

  ///Получение списка добавленных продуктов в избранное
  Future<List<ProductModel>> getListFavourite() async {
    return await mainDb.getFavouritesList();
  }

  ///Проверить существует ли продукт в избранном по [id]
  Future<bool> favouriteProductExists(int id, int currentUserId) async {
    return await mainDb.productExists(id, currentUserId);
  }
}
