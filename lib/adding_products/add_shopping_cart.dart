import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';

/// Класс описывает добавление товара в корзину
class AddShoppingCart extends ChangeNotifier {
  static final AddShoppingCart _instance = AddShoppingCart._internal();

  Map<Product, int> products = {};

  factory AddShoppingCart() {
    return _instance;
  }

  AddShoppingCart._internal();

  /// Формируем список товаров добавляемых в корзину
  Map<Product, int> setProduct(Product product) {
    products.update(product, (value) => ++value, ifAbsent: () => 1);
    notifyListeners();
    return products;
  }

  ///Метод увеличения количества добавленного товара
  void quantityUp(Product product) {
    products.update(product, (value) => ++value);
    notifyListeners();
  }

  ///Метод уменьшения количества добавленного товара
  ///Если счётчик достиг нуля то продукт удаляется ипз корзины
  void quantityDown(Product product) {
    products.update(product, (value) => --value);
    if (products[product] == 0) {
      products.remove(product);
    }
    notifyListeners();
  }

  ///Подсчёт суммы добавляемого товара в корзину
  int getSumProducts() {
    int sumProducts = 0;
    for (var product in products.keys) {
      sumProducts += product.priceProduct * products[product]!;
    }
    return sumProducts;
  }

  ///Возвращаем список добавленных товаров
  Map<Product, int> getProduct() {
    return products;
  }

  ///Метод очищает список товаров
  void removeProducts() {
    products.clear();
    notifyListeners();
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
