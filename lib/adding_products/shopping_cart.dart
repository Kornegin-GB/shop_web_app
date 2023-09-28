import 'package:shop_web_app/adding_products/product.dart';

/// Класс описывает добавление товара в корзину
class ShoppingCart {
  static final ShoppingCart _instance = ShoppingCart._internal();

  List<Product> products = [];

  factory ShoppingCart() {
    return _instance;
  }

  ShoppingCart._internal();

  List<Product> setProduct(Product addProduct) {
    products.add(Product(
        nameProduct: addProduct.nameProduct,
        descriptionProduct: addProduct.descriptionProduct,
        priceProduct: addProduct.priceProduct,
        imgProduct: addProduct.imgProduct));
    return products;
  }

  int getSumProducts(List<Product> products) {
    int sumProducts = 0;
    for (var element in products) {
      sumProducts += element.priceProduct;
    }
    return sumProducts;
  }

  List<Product> getProduct() {
    return products;
  }
}
//TODO: Выполнить
// 2. При достижении 0 товар удаляется из корзины
// 3. Общая сумма при этом должна пересчитываться
