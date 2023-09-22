///Класс описывает продукт
class Product {
  final String nameProduct;
  final String descriptionProduct;
  final String imgProduct;
  final int priceProduct;

  Product({
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.imgProduct,
  });

  factory Product.fromJson(Map<String, dynamic> parsJson) {
    return Product(
      nameProduct: parsJson['nameProduct'],
      descriptionProduct: parsJson['descriptionProduct'],
      priceProduct: parsJson['priceProduct'],
      imgProduct: parsJson['imgProduct'],
    );
  }
}
