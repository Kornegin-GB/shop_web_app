import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_web_app/adding_products/product.dart';

///Класс реализует добавление в лист продукты из базы данных
class AddListProduct {
  List<Product> products = [];

  Future<List<Product>> getProductList() async {
    final response = await rootBundle.loadString('assets/json/product.json');
    final data = jsonDecode(response)["products"] as List;
    List<Product> productList = data.map((e) => Product.fromJson(e)).toList();
    return productList;
  }
}
