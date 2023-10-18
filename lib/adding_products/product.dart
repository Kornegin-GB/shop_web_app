///Класс описывает продукт
class Product {
  final int productId;
  final String nameProduct;
  final String descriptionProduct;
  final String imgProduct;
  final int priceProduct;

  Product({
    required this.productId,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.imgProduct,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'descriptionProduct': descriptionProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'imgProduct': imgProduct
    };
  }

  factory Product.fromJson(Map<String, dynamic> parsJson) {
    return Product(
      productId: parsJson['productId'],
      nameProduct: parsJson['nameProduct'],
      descriptionProduct: parsJson['descriptionProduct'],
      priceProduct: parsJson['priceProduct'],
      imgProduct: parsJson['imgProduct'],
    );
  }
}
