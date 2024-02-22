import 'package:eshop/service/model/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Product> cartItems = <Product>[].obs;
  
  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  
}


