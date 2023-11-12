///Класс описывает модель продукта
class ProductModel {
  final int? id;
  final int productId;
  final String nameProduct;
  final String descriptionProduct;
  final String imgProduct;
  final int priceProduct;
  final int? fkUserId;

  ProductModel({
    this.id,
    required this.productId,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.imgProduct,
    this.fkUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'descriptionProduct': descriptionProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'imgProduct': imgProduct,
      'FK_userId': fkUserId
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> parsJson) {
    return ProductModel(
      id: parsJson['id'],
      productId: parsJson['productId'],
      nameProduct: parsJson['nameProduct'],
      descriptionProduct: parsJson['descriptionProduct'],
      priceProduct: parsJson['priceProduct'],
      imgProduct: parsJson['imgProduct'],
      fkUserId: parsJson['FK_userId'],
    );
  }
}
