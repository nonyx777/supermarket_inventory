import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:supermarket_inventory/View/Market/market_page.dart';
import 'package:supermarket_inventory/View/Navigation/BottomNavBar.dart';
import 'package:supermarket_inventory/View/Profile/profile_screen.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int index = 0;
  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Widget child = const StoreManagement();
    switch (index) {
      case 0:
        child = const StoreManagement();
        break;
      case 1:
        child = const MarketPage();
        break;
      case 2:
        child = ProfileScreen();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 33, 61),
        title: const Text(
          style: TextStyle(
            color: Color.fromARGB(255, 252, 163, 17),
            fontSize: 25,
          ),
          "Products",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout_rounded,
                size: height * 0.035,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: child,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
