import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/components/LoginTextfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/logo.png"),
                    const Text(
                      'Inventory',
                      style: TextStyle(
                          color: Color.fromARGB(255, 20, 33, 61),
                          fontSize: 46,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 33, 61),
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      controller: forgotPasswordController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        var forgotEmail = forgotPasswordController.text.trim();

                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgotEmail)
                              .then((value) => {
                                    Fluttertoast.showToast(
                                        msg: "Email Sent",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginForm()),
                                    ),
                                  });
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              msg: "Error While Sending the Email! Try Again",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 20, 33, 61),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Send Verification",
                            style: TextStyle(
                              color: Color.fromARGB(255, 252, 163, 17),
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
