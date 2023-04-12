import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/Profile/profile_screen.dart';
import 'package:supermarket_inventory/View/Profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello " + user.email!),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out")),
          SizedBox(
            height: height * 0.01,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await googleLogout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              },
              child: Text("Google Log Out")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Text("Profile Page"))
        ],
      ),
    )));
  }
}
