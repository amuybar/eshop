import 'package:eshop/service/model/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Product> cartItems = <Product>[].obs;
  RxInt itemCount = 0.obs;

  void addToCart(Product product) {
    if (!cartItems.any((item) => item.id == product.id)) {
      cartItems.add(product);
      itemCount++;
    }
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }
}
