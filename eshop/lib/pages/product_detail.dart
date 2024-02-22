import 'package:eshop/pages/widgets/home.dart';
import 'package:eshop/service/model/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Badge(
        label: Text("2"),
        child: FaIcon(FontAwesomeIcons.cartPlus,size: 55,color: Colors.yellow,)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),  const SizedBox(height: 8),
              Image.network(
                product.imgurl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                'Price: \$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                product.descr,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Quantity: ${product.qnty}',
                style: const TextStyle(fontSize: 18),
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: (){ favtr.addToFavorites(product);},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: (){ cartController.addToCart(product);},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
