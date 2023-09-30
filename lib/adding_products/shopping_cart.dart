import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';

/// Класс описывает добавление товара в корзину
class ShoppingCart extends ChangeNotifier {
  static final ShoppingCart _instance = ShoppingCart._internal();

  Map<Product, int> products = {};

  factory ShoppingCart() {
    return _instance;
  }

  ShoppingCart._internal();

  /// Формируем список товаров добавляемых в корзину
  Map<Product, int> setProduct(Product product) {
    notifyListeners();
    products.update(product, (value) => ++value, ifAbsent: () => 1);
    return products;
  }

  ///Метод увеличения количества добавленного товара
  void quantityUp(Product product) {
    notifyListeners();
    products.update(product, (value) => ++value);
  }

  ///Метод уменьшения количества добавленного товара
  ///Если счётчик достиг нуля то продукт удаляется ипз корзины
  void quantityDown(Product product) {
    notifyListeners();
    products.update(product, (value) => --value);
    if (products[product] == 0) {
      products.remove(product);
    }
  }

  ///Подсчёт суммы добавляемого товара в корзину
  int getSumProducts() {
    int sumProducts = 0;
    for (var product in products.keys) {
      sumProducts += product.priceProduct * products[product]!;
    }
    // notifyListeners();
    return sumProducts;
  }

  ///Возвращаем список добавленных товаров
  Map<Product, int> getProduct() {
    notifyListeners();
    return products;
  }

  ///Метод очищает список товаров
  void removeProducts() {
    notifyListeners();
    products.clear();
  }

  ///Метод счётчик, подсчёт количество товаров в корзине
  int getCounterProducts() {
    int count = 0;
    for (int quantityProduct in products.values) {
      count += quantityProduct;
    }
    return count;
  }
}
