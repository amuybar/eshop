import 'package:eshop/pages/product_detail.dart';
import 'package:eshop/service/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final double productPrice;
  final Function()? onFavoritePressed;
  final Function()? onCartPressed;
  final Product product;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productImageUrl,
    required this.productPrice,
    required this.product,
    this.onFavoritePressed,
    this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailScreen(
          product: product,
        ));
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                overflow: TextOverflow.fade,
                maxLines: 2,
                productName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  productImageUrl,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.dstOver,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$$productPrice',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: onFavoritePressed,
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: onCartPressed,
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
