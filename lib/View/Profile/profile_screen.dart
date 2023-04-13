import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/Profile/change_password.dart';
import 'package:supermarket_inventory/View/Profile/profile_menu.dart';
import 'package:supermarket_inventory/View/Profile/profile_pic.dart';
import 'package:supermarket_inventory/View/Profile/profile_screen.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            ProfilePic(),
            SizedBox(height: height * 0.05),
            ProfileMenu(
              text: "Change Password",
              icon: Icon(Icons.change_circle,
                  color: Color.fromARGB(255, 252, 163, 17)),
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icon(
                Icons.notifications_active,
                color: Color.fromARGB(255, 252, 163, 17),
              ),
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 252, 163, 17),
              ),
              press: () async {
                await googleLogout();
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
