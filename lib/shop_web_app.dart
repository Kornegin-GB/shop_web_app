import 'package:flutter/material.dart';
import 'package:shop_web_app/add_list_product.dart';

class ShopWebApp extends StatefulWidget {
  const ShopWebApp({super.key});

  @override
  State<ShopWebApp> createState() => _ShopWebAppState();
}

class _ShopWebAppState extends State<ShopWebApp> {
  var productList = AddListProduct().productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop web app')),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Card(
                color: Theme.of(context).colorScheme.background,
                child: InkWell(
                  onTap: () {
                    //TODO: Сделать переход на страницу товара
                  },
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/${productList[index].productImage}'),
                        width: 150,
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productList[index].productName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(productList[index].productDescription),
                          Text(
                              'Цена: ${productList[index].productPrise.toString()}'),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
