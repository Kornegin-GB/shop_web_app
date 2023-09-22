import 'package:shop_web_app/adding_products/product.dart';

/// Класс описывает добавление товара в корзину
class AddShoppingCart {
  static final AddShoppingCart _instance = AddShoppingCart._internal();

  List<Product> products = [];
  int sumProducts = 0;

  factory AddShoppingCart() {
    return _instance;
  }

  AddShoppingCart._internal();

  List<Product> setProduct(Product addProduct) {
    products.add(Product(
        nameProduct: addProduct.nameProduct,
        descriptionProduct: addProduct.descriptionProduct,
        priceProduct: addProduct.priceProduct,
        imgProduct: addProduct.imgProduct));
    // sumProducts += addProduct.priceProduct;
    return products;
  }

  int getSumProducts(List<Product> products) {
    sumProducts = 0;
    for (var element in products) {
      sumProducts += element.priceProduct;
    }
    return sumProducts;
  }

  List<Product> getProduct() {
    return products;
  }
}

//TODO: Пересмотреть подсчёт суммы
