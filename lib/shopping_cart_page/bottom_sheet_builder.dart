import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_web_app/adding_products/add_shopping_cart.dart';

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
    return Consumer<AddShoppingCart>(
      builder: (context, value, child) => BottomSheet(
        builder: (_) {
          return Container(
            padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: [
                    Text(
                      'Amount: ${value.getSumProducts()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Icon(Icons.currency_ruble, size: 18),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    minimumSize: const Size(165, 40),
                  ),
                  onPressed: () {
                    if (value.products.isNotEmpty) {
                      value.removeProducts();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Products successfully purchased!'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'BUY',
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
