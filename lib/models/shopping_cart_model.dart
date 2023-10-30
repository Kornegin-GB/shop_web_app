import 'package:flutter/material.dart';
import 'package:shop_web_app/database_helper/database_app.dart';
import 'package:shop_web_app/models/cart_product_model.dart';
import 'package:shop_web_app/models/product_model.dart';

/// Класс описывает добавление товара в корзину
class ShoppingCartModel extends ChangeNotifier {
  static final ShoppingCartModel _instance = ShoppingCartModel._internal();
  final mainDB = DatabaseApp.db;

  List<CartProductModel> products = [];

  factory ShoppingCartModel() {
    return _instance;
  }

  ShoppingCartModel._internal();

  ///Формируем продукт в корзине
  CartProductModel _toCartProduct(ProductModel product, int quantity) {
    return CartProductModel(
      productId: product.productId,
      nameProduct: product.nameProduct,
      priceProduct: product.priceProduct,
      imgProduct: product.imgProduct,
      quantityProduct: ++quantity,
    );
  }

  /// Формируем список товаров добавляемых в корзину
  List<CartProductModel> addProduct(ProductModel product) {
    int quantity = 0;
    if (products.any((element) => element.productId == product.productId)) {
      CartProductModel productCart = products
          .firstWhere((element) => element.productId == product.productId);
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

  ///Получение количества одного продукта
  int getQuantity(CartProductModel product) {
    return product.quantityProduct;
  }

  ///Метод увеличения количества добавленного товара
  void quantityUp(CartProductModel product) {
    product.quantityProduct++;
    mainDB.updateProduct(product, mainDB.tableSoppingCart);
    notifyListeners();
  }

  ///Метод уменьшения количества добавленного товара
  ///Если счётчик достиг нуля то продукт удаляется ипз корзины
  void quantityDown(CartProductModel product) {
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
  loadProduct() {
    return mainDB.getAllCartProduct().then((productsDb) {
      products = productsDb;
      notifyListeners();
    });
  }

  ///Метод очищает список товаров
  void removeProducts() {
    products.clear();
    mainDB.clearCartProduct();
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
