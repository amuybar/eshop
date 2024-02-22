// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:eshop/pages/widgets/cart.dart';
import 'package:eshop/pages/widgets/fav.dart';
import 'package:eshop/pages/widgets/home.dart';
import 'package:eshop/pages/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
bool isSerch = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSerch?const Text('Eshop'):TextField(),
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
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        selectedFontSize: 23,
        selectedItemColor: Colors.black.withBlue(56),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.shoppingCart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Person',
          ),
        ],
      ),
    );
  }
}
