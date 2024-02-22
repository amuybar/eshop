// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:convert';

import 'package:eshop/pages/product_detail.dart';
import 'package:eshop/pages/widgets/cart.dart';
import 'package:eshop/pages/widgets/fav.dart';
import 'package:eshop/pages/widgets/home.dart';
import 'package:eshop/pages/widgets/profile.dart';
import 'package:eshop/service/controllers/cart_controller.dart';
import 'package:eshop/service/model/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

int index = 0;
final pages = <Widget>[
  const HomeWidget(),
  Cart(),
  Fav(),
  const Profile(),
];
bool isSerch = true;
final CartController cartController = Get.put(CartController());

class HighlightedText {
  final String before;
  final String matching;
  final String after;

  HighlightedText({required this.before, required this.matching, required this.after});
}

HighlightedText getHighlightedText(String text, String query) {
  final queryLower = query.toLowerCase();
  final textLower = text.toLowerCase();
  final startIndex = textLower.indexOf(queryLower);

  if (startIndex != -1) {
    final endIndex = startIndex + queryLower.length;
    return HighlightedText(
      before: text.substring(0, startIndex),
      matching: text.substring(startIndex, endIndex),
      after: text.substring(endIndex),
    );
  } else {
    return HighlightedText(before: text, matching: '', after: '');
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];
  
  Future<void> fetchSearchResults(String query) async {
  if (query.isNotEmpty) { // Check if query is not empty
    final response = await http.get(Uri.parse('http://localhost:3000/products?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        searchResults = data.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load search results');
    }
  } else {
    setState(() {
      searchResults = []; // Clear search results if query is empty
    });
  }
}


  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSerch
            ? const Text('Eshop')
            : TextField(
                controller: searchController,
                onChanged: (value) {
                  fetchSearchResults(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(FontAwesomeIcons.searchengin),
            onPressed: () {
              setState(() {
                isSerch = !isSerch;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Drawer Item 1'),
              onTap: () {
                // Add your drawer item 1 action here
              },
            ),
            ListTile(
              title: const Text('Drawer Item 2'),
              onTap: () {
                // Add your drawer item 2 action here
              },
            ),
          ],
        ),
      ),
      body: isSerch ? pages[index] : searchScreen(),
      bottomNavigationBar: Obx(
         () {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            selectedFontSize: 23,
            selectedItemColor: Colors.black.withBlue(56),
            unselectedItemColor: Colors.black,
            items:  [
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Badge(
            label: Text('${cartController.itemCount}'),child: const Icon(FontAwesomeIcons.shoppingCart)),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Badge(
            label: Text('${favtr.itemCount}'),child: const Icon(FontAwesomeIcons.heart)),
                label: 'Favorite',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user),
                label: 'Person',
              ),
            ],
          );
        }
      ),
    );
  }

  ListView searchScreen() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        final highlightedName =
            getHighlightedText(product.name, searchController.text);
        return ListTile(
          leading:  SizedBox(
                    width: 70, 
                    height: 60, 
                    child: Image.network(product.imgurl),
                  ),
          title:  RichText(
            overflow: TextOverflow.fade, 
            maxLines: 2,
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(text: highlightedName.before, style: const TextStyle(fontWeight: FontWeight.normal)),
            TextSpan(text: highlightedName.matching, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: highlightedName.after, style: const TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product)),
            );
          },
        );
      },
    );
  }
}
