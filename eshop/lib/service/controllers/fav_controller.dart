import 'package:eshop/service/model/product.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<Product> favoriteProducts = <Product>[].obs;

  void addToFavorites(Product product) {
    favoriteProducts.add(product);
  }

  void removeFromFavorites(Product product) {
    favoriteProducts.remove(product);
  }

  bool isFavorite(Product product) {
    return favoriteProducts.contains(product);
  }
}