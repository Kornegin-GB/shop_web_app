import 'package:flutter/material.dart';
import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:shop_web_app/models/cart_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';
import 'package:shop_web_app/models/user_authorization_model.dart';

/// Класс описывает добавление товара в корзину (модель корзины)
class ShoppingCartModel extends ChangeNotifier {
  static final ShoppingCartModel _instance = ShoppingCartModel._internal();
  final mainDB = DatabaseApp.db;

  List<CartProductModel> products = [];

  factory ShoppingCartModel() {
    return _instance;
  }

  ShoppingCartModel._internal();

  ///Формируем [product] в корзине c изменением [quantity]
  CartProductModel _toCartProduct(ProductModel product, int quantity) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    return CartProductModel(
      productId: product.productId,
      nameProduct: product.nameProduct,
      priceProduct: product.priceProduct,
      imgProduct: product.imgProduct,
      fkUserId: userId,
      quantityProduct: ++quantity,
    );
  }

  /// Формируем список [product] добавляемых в корзину
  List<CartProductModel> addProduct(ProductModel product) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    int quantity = 0;
    if (products.any((element) =>
        element.productId == product.productId && element.fkUserId == userId)) {
      CartProductModel productCart = products.firstWhere((element) =>
          element.productId == product.productId && element.fkUserId == userId);
      productCart.quantityProduct++;
      mainDB.updateProduct(productCart, mainDB.tableSoppingCart);
    } else {
      CartProductModel item = _toCartProduct(product, quantity);
      products.add(item);
      mainDB.insertProduct(item, mainDB.tableSoppingCart);
    }
    notifyListeners();
    return products;
  }

  ///Получение количества одного [product] в корзину
  int getQuantity(CartProductModel product) {
    return product.quantityProduct;
  }

  ///Метод увеличения количества добавленного [product] в корзину
  void quantityUp(CartProductModel product) {
    product.quantityProduct++;
    mainDB.updateProduct(product, mainDB.tableSoppingCart);
    notifyListeners();
  }

  ///Метод уменьшения количества добавленного [product] в корзину
  ///
  ///Если счётчик достиг нуля то [product] удаляется из корзины
  void quantityDown(CartProductModel product) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    product.quantityProduct--;
    mainDB.updateProduct(product, mainDB.tableSoppingCart);
    if (product.quantityProduct == 0) {
      products.remove(product);
      mainDB.deleteProduct(product.productId, userId!, mainDB.tableSoppingCart);
    }
    notifyListeners();
  }

  ///Подсчёт суммы добавляемого товара в корзину
  int getSumProducts() {
    int sumProducts = 0;
    for (var product in products) {
      sumProducts += product.priceProduct * product.quantityProduct;
    }
    return sumProducts;
  }

  ///Загружаем сохранённый список добавленных товаров
  loadProduct() {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    if (userId != null) {
      return mainDB.getCartProductCurrentUser(userId).then((productsDb) {
        products = productsDb;
      });
    }
    notifyListeners();
  }

  ///Метод очищает список товаров
  void removeProducts() {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    products.clear();
    mainDB.clearCartProduct(userId!);
    notifyListeners();
  }

  ///Метод счётчик, подсчёт общего количества товаров в корзине
  int getCounterProducts() {
    int count = 0;
    for (var countProduct in products) {
      count += countProduct.quantityProduct;
    }
    return count;
  }

  ///Метод удаления продукта из корзины
  deleteProduct(CartProductModel product) {
    int? userId = UserAuthorizationModel().currentUser?.userId;
    products.remove(product);
    mainDB.deleteProduct(product.productId, userId!, mainDB.tableSoppingCart);
    notifyListeners();
  }
}
