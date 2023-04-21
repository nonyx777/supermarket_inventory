import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/View/components/LoginTextfield.dart';
import 'package:supermarket_inventory/color/color.dart';
import 'package:supermarket_inventory/color/color.dart';

import '../LoginForm.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var newPassword = "";
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      Fluttertoast.showToast(
          msg: "Password Changed Succesfully".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: dangerRed,
          textColor: pureWhite);
    } catch (error) {}
  }

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/logo.png"),
                    Text(
                      'Inventory'.tr(),
                      style: const TextStyle(
                          color: blueBlack,
                          fontSize: 46,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Change Password'.tr(),
                      style: const TextStyle(
                        color: blueBlack,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    MyTextField(
                      controller: newPasswordController,
                      hintText: 'Enter Your New Password'.tr(),
                      obscureText: false,
                    ),
                    SizedBox(height: height * 0.015),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePassword();
                        await googleLogout();
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginForm()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: blueBlack,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Change Password".tr(),
                            style: const TextStyle(
                              color: orangeAccent,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
