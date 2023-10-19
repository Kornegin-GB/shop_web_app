import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/database_app.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart.dart';

/// Класс описывает добавление товара в корзину
class AddShoppingCart extends ChangeNotifier {
  static final AddShoppingCart _instance = AddShoppingCart._internal();
  final mainDB = DatabaseApp.db;

  List<ShoppingCart> products = [];

  factory AddShoppingCart() {
    return _instance;
  }

  AddShoppingCart._internal();

  ///Формируем продукт в корзине
  ShoppingCart addNewProduct(Product product, int quantity) {
    return ShoppingCart(
      productId: product.productId,
      nameProduct: product.nameProduct,
      priceProduct: product.priceProduct,
      imgProduct: product.imgProduct,
      quantityProduct: ++quantity,
    );
  }

  /// Формируем список товаров добавляемых в корзину
  List<ShoppingCart> setProduct(Product product) {
    int quantity = 0;
    if (products.any((element) => element.productId == product.productId)) {
      ShoppingCart productCart = products
          .firstWhere((element) => element.productId == product.productId);
      productCart.quantityProduct++;
      mainDB.updateProduct(productCart, mainDB.tableSoppingCart);
    } else {
      ShoppingCart item = addNewProduct(product, quantity);
      products.add(item);
      mainDB.insertProduct(item, mainDB.tableSoppingCart);
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
    mainDB.updateProduct(product, mainDB.tableSoppingCart);
    notifyListeners();
  }

  ///Метод уменьшения количества добавленного товара
  ///Если счётчик достиг нуля то продукт удаляется ипз корзины
  void quantityDown(ShoppingCart product) {
    product.quantityProduct--;
    mainDB.updateProduct(product, mainDB.tableSoppingCart);
    if (product.quantityProduct == 0) {
      products.remove(product);
      mainDB.deleteProduct(product.productId, mainDB.tableSoppingCart);
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
  getProduct() {
    return mainDB
        .showAllProductsShoppingCart()
        .then((productsDb) {
      products = productsDb;
      notifyListeners();
    });
  }

  ///Метод очищает список товаров
  void removeProducts() {
    products.clear();
    mainDB.deleteTable(mainDB.tableSoppingCart);
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
