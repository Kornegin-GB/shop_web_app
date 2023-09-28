import 'package:flutter/material.dart';

class BuilderAppBar extends StatelessWidget {
  const BuilderAppBar({super.key, required this.titleApp});

  final String titleApp;

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleApp),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          icon: const Icon(
            Icons.add_shopping_cart,
            size: 30,
          ),
        ),
      ],
    );
  }
}
/*TODO: рядом с корзиной сделать счётчик общий товаров.
 соответственно при добавлении товаров этот счётчик будет увеличиваться
 */
