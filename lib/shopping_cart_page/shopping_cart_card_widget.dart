import 'package:flutter/material.dart';
import 'package:shop_web_app/adding_products/product.dart';

class ShoppingCartCardWidget extends StatefulWidget {
  const ShoppingCartCardWidget({
    super.key,
    required this.products,
    required this.index,
  });

  final List<Product> products;
  final int index;

  @override
  State<ShoppingCartCardWidget> createState() => _ShoppingCartCardWidgetState();
}

class _ShoppingCartCardWidgetState extends State<ShoppingCartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          Image(
            image: AssetImage(
                'assets/images/${widget.products[widget.index].imgProduct}'),
            width: 150,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products[widget.index].nameProduct,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Text(
                        'Цена: ${widget.products[widget.index].priceProduct.toString()} р.'),
                    // const Padding(padding: EdgeInsets.all(5)),

                    ///Начало
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            onPressed: () {
                              setState(() {
                                //TODO: Функция увеличения счётчика
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          const Text(
                            '1',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            onPressed: () {
                              setState(() {
                                //TODO: Функция уменьшения счётчика
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    ///Окончаниеы
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO:  у каждого товара сделать счётчик +/- который будет управлять
//  количеством товара
