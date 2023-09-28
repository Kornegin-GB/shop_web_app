import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_page.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Product> products = ShoppingCart().getProduct();
  late int sumProducts = ShoppingCart().getSumProducts(products);

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
        bottomSheet: BottomSheet(
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
