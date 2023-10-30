import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/models/shopping_cart_model.dart';
import 'package:shop_web_app/shopping_cart_page/shopping_cart_card_widget.dart';

///Формирование страницы корзины
class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartModel>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ShoppingCartCardWidget(
              product: value.products.elementAt(index));
        },
      ),
    );
  }
}
