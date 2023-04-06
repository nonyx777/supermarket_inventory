import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:supermarket_inventory/View/components/LoginButton.dart';

class Homeage extends StatefulWidget {
  const Homeage({super.key});

  @override
  State<Homeage> createState() => _HomeageState();
}

class _HomeageState extends State<Homeage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        children: [
          Text("Hello" + user.email!),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out"))
        ],
      ),
    )));
  }
}
