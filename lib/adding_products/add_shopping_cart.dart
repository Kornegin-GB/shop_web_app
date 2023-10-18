import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart.dart';

/// Класс описывает добавление товара в корзину
class AddShoppingCart extends ChangeNotifier {
  static final AddShoppingCart _instance = AddShoppingCart._internal();

  List<ShoppingCart> products = [];

  factory AddShoppingCart() {
    return _instance;
  }

  AddShoppingCart._internal();

  /// Формируем список товаров добавляемых в корзину
  List<ShoppingCart> setProduct(Product product) {
    int quantity = 0;
    if (products.any((element) => element.productId == product.productId)) {
      ShoppingCart productCart = products
          .firstWhere((element) => element.productId == product.productId);
      productCart.quantityProduct++;
    } else {
      products.add(ShoppingCart(
        productId: product.productId,
        nameProduct: product.nameProduct,
        priceProduct: product.priceProduct,
        imgProduct: product.imgProduct,
        quantityProduct: ++quantity,
      ));
    }
    notifyListeners();
    return products;
  }

  ///Получение количества одного продукта
  int getQuantity(ShoppingCart product) {
    return product.quantityProduct;
  }

  ///Метод увеличения количества добавленного товара
  void quantityUp(ShoppingCart product) {
    product.quantityProduct++;
    notifyListeners();
  }

  ///Метод уменьшения количества добавленного товара
  ///Если счётчик достиг нуля то продукт удаляется ипз корзины
  void quantityDown(ShoppingCart product) {
    product.quantityProduct--;
    if (product.quantityProduct == 0) {
      products.remove(product);
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

  ///Возвращаем список добавленных товаров
  List<ShoppingCart> getProduct() {
    return products;
  }

  ///Метод очищает список товаров
  void removeProducts() {
    products.clear();
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
}
