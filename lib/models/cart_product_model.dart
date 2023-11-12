///Класс описывает модель корзины
class CartProductModel {
  final int? id;
  final int productId;
  final String nameProduct;
  final String imgProduct;
  final int priceProduct;
  late int quantityProduct;
  final int? fkUserId;

  CartProductModel({
    this.id,
    required this.productId,
    required this.nameProduct,
    required this.priceProduct,
    required this.imgProduct,
    required this.quantityProduct,
    this.fkUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'imgProduct': imgProduct,
      'quantityProduct': quantityProduct,
      'FK_userId': fkUserId
    };
  }

  factory CartProductModel.fromJson(Map<String, dynamic> parsJson) {
    return CartProductModel(
      id: parsJson['id'],
      productId: parsJson['productId'],
      nameProduct: parsJson['nameProduct'],
      priceProduct: parsJson['priceProduct'],
      imgProduct: parsJson['imgProduct'],
      quantityProduct: parsJson['quantityProduct'],
      fkUserId: parsJson['FK_userId'],
    );
  }
}
