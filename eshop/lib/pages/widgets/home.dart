import 'package:eshop/pages/widgets/dropdown.dart';
import 'package:eshop/pages/widgets/productcard.dart';
import 'package:eshop/service/controllers/cart_controller.dart';
import 'package:eshop/service/controllers/fav_controller.dart';
import 'package:eshop/service/model/product.dart';
import 'package:eshop/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

String valfilter2 = 'New Arrivals';
String valfilter1 = 'Electronics';
final FavoriteController favtr = Get.put(FavoriteController());
final CartController cartController = Get.put(CartController());

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Static row for filter values
        Container(
          height: 50,
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Filter:',
                style: TextStyle(
                  color: Colors.black.withBlue(55),
                  fontSize: 18,
                ),
              ),
              SizedBox(
                child: CustomDropDown(
                  initialValue: valfilter1,
                  onChanged: (val) {
                    setState(() {
                      valfilter1 = val!;
                    });
                  },
                  items: const ['Electronics', 'Fashion', 'Books'],
                ),
              ),
              SizedBox(
                child: CustomDropDown(
                  initialValue: valfilter2,
                  onChanged: (val) {
                    setState(() {
                      valfilter2 = val!;
                    });
                  },
                  items: const ['New Arrivals', 'Price', 'Availability'],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: ProductService.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.71,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];

                    return ProductCard(
                      productName: product.name,
                      productImageUrl: product.imgurl,
                      productPrice: product.price,
                      onFavoritePressed: () {
                        favtr.addToFavorites(product);
                        // Handle favorite button pressed
                      },
                      onCartPressed: () {
                        cartController.addToCart(product);
                        // Handle cart button pressed
                      }, product: product,
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }
}
