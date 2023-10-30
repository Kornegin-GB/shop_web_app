import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop_web_app/models/product_model.dart';

///Класс реализует получения списка продуктов из файла JSON
class LoadingListProducts {
  Future<List<ProductModel>> getProductList() async {
    final response = await rootBundle.loadString('assets/json/product.json');
    final data = jsonDecode(response)["products"] as List;
    List<ProductModel> productList =
        data.map((e) => ProductModel.fromJson(e)).toList();
    return productList;
  }
}
