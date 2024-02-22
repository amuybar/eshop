import 'package:eshop/service/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
 Cart({ Key? key }) : super(key: key);
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];
                  return Card(
                    child: ListTile(
                      leading: SizedBox(
                        width: 40, 
                        height: 40, 
                        child: Image.network(product.imgurl),
                      ),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price.toString()}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Text(
                'Total: \$${cartController.getTotalPrice().toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}