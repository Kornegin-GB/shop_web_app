import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/authorization_page/authorization_page.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';

class BuilderAppBar extends StatelessWidget {
  const BuilderAppBar({
    super.key,
    required this.titleApp,
    required this.withCart,
  });

  final bool withCart;
  final String titleApp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleApp),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthorizationPage()),
                  );
                },
                icon: const Icon(Icons.person)),
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
                      Consumer<ShoppingCartModel>(
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
        )
      ],
    );
  }
}
