///Класс описывает продукт
class Product {
  String _productName = '';
  String _productDescription = '';
  String _fullProductDescription = '';
  String _productImage = '';
  int _productPrise = 0;

  Product(this._productName, this._productDescription,
      this._fullProductDescription, this._productPrise, this._productImage);

  String get productImage => _productImage;

  String get productDescription => _productDescription;

  String get productName => _productName;

  String get fullProductDescription => _fullProductDescription;

  int get productPrise => _productPrise;
}
