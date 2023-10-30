import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/builder_app_bar.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/shopping_cart_page/bottom_sheet_builder.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_page.dart';

/// Класс главного экрана корзины товаров
class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BuilderAppBar(titleApp: 'Shopping cart', withCart: false),
      ),
      body: Consumer<ShoppingCartModel>(
        builder: (context, value, child) => (value.products.isEmpty)
            ? const Center(
                child: Text(
                  'Shopping cart empty',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : const ShoppingCartPage(),
      ),
      bottomNavigationBar: const BottomSheetBuilder(),
    );
  }
}
