import 'package:flutter/material.dart';
import 'package:shop_web_app/add_list_product.dart';
import 'package:shop_web_app/product.dart';

class ProductListApp extends StatefulWidget {
  const ProductListApp({super.key});

  @override
  State<ProductListApp> createState() => _ProductListAppState();
}

class _ProductListAppState extends State<ProductListApp> {
  List<Product> products = [];

  Future<void> _loadProductsList() async {
    products = await AddListProduct().getProductList();
    setState(() {});
  }

  @override
  void initState() {
    _loadProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop web app')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(products: products[index]);
        },
      ),
    );
  }
}

/// Класс рисует карточку товара списка
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.products,
  });

  final Product products;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: products);
        },
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/images/${products.imgProduct}'),
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
                      products.nameProduct,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Text(
                      products.descriptionProduct,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Text('Цена: ${products.priceProduct.toString()} р.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
