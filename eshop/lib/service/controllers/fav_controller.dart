import 'package:eshop/service/model/product.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<Product> favoriteProducts = <Product>[].obs;
  RxInt itemCount = 0.obs;
  void addToFavorites(Product product) {
    if (!favoriteProducts.any((item) => item.id == product.id)) {
      favoriteProducts.add(product);
      itemCount++;
    }
  }

  void removeFromFavorites(Product product) {
    favoriteProducts.remove(product);
  }

  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }
}
