import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';

class BuilderAppBar extends StatelessWidget {
  BuilderAppBar({super.key, required this.titleApp, required this.withCart});

  bool withCart;
  final String titleApp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleApp),
        (withCart)
            ? Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      size: 30,
                    ),
                  ),
                  Consumer<ShoppingCart>(
                    builder: (context, value, child) =>
                        (value.getCounterProducts() > 0)
                            ? Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.zero,
                                child: Center(
                                  child: Text(
                                    '${value.getCounterProducts()}',
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                  )
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}