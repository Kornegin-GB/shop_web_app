import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/shopping_cart.dart';

class BottomSheetBuilder extends StatefulWidget {
  const BottomSheetBuilder({
    super.key,
  });

  @override
  State<BottomSheetBuilder> createState() => _BottomSheetBuilderState();
}

class _BottomSheetBuilderState extends State<BottomSheetBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCart>(
      builder: (context, value, child) => BottomSheet(
        builder: (_) {
          return Container(
            padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                Text(
                  'Сумма: ${value.getSumProducts()} р',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  onPressed: () {
                    if (value.products.isNotEmpty) {
                      value.removeProducts();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Товар успешно куплен!'),
                        ),
                      );
                    }
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
      ),
    );
  }
}
