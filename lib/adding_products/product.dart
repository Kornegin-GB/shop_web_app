///Класс описывает продукт
class Product {
  final int id;
  final String nameProduct;
  final String descriptionProduct;
  final String imgProduct;
  final int priceProduct;

  Product({
    required this.id,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.imgProduct,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descriptionProduct': descriptionProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'imgProduct': imgProduct
    };
  }

  factory Product.fromJson(Map<String, dynamic> parsJson) {
    return Product(
      id: parsJson['id'],
      nameProduct: parsJson['nameProduct'],
      descriptionProduct: parsJson['descriptionProduct'],
      priceProduct: parsJson['priceProduct'],
      imgProduct: parsJson['imgProduct'],
    );
  }
}
