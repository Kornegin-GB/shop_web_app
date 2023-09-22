import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/add_shopping_cart.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_page.dart';

class ShoppingCartApp extends StatefulWidget {
  const ShoppingCartApp({super.key});

  @override
  State<ShoppingCartApp> createState() => _ShoppingCartAppState();
}

class _ShoppingCartAppState extends State<ShoppingCartApp> {
  List<Product> products = AddShoppingCart().getProduct();
  late int sumProducts = AddShoppingCart().getSumProducts(products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const BuilderAppBar(titleApp: 'Корзина'),
        ),
        body: (products.isEmpty)
            ? const Center(
                child: Text(
                  'Корзина пустая',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : ShoppingCartPage(products: products),
        bottomSheet: //(products.isNotEmpty)
            // ?
            BottomSheet(
          builder: (_) {
            return Container(
              padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                    'Сумма: $sumProducts р',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                    onPressed: () {
                      products.clear();
                      sumProducts = 0;
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Успешно!')));
                    },
                    child: const Text(
                      'Купить',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
            );
          },
          onClosing: () {},
        )
        // : null
        );
  }
}
