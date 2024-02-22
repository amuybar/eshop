import 'package:eshop/service/controllers/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fav extends StatelessWidget {
 Fav({ Key? key }) : super(key: key);
 final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Obx(() => ListView.builder(
            itemCount: favoriteController.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteController.favoriteProducts[index];
              return Card(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      favoriteController.removeFromFavorites(product);
                    },
                  ),
                ),
              );
            },
          )),
    );
  }
}