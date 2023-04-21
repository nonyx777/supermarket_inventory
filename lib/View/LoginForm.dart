import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/ForgetPassword.dart';
import 'package:supermarket_inventory/View/HomePage.dart';
import 'package:supermarket_inventory/View/Navigation/ParentPage.dart';
import 'package:supermarket_inventory/View/SignUp.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';
import 'package:supermarket_inventory/View/components/LoginButton.dart';
import 'package:supermarket_inventory/View/components/LoginTextfield.dart';
import 'package:supermarket_inventory/View/components/square_tile.dart';
import 'package:supermarket_inventory/color/color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void signInUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "Incorrect Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: dangerRed,
            textColor: pureWhite);
      }
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "incorrect_password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: dangerRed,
            textColor: pureWhite);
      }
    }
    Navigator.pop(context);
  }

  Future<void> signInWithGoogle() async {
    //Create Instance
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    //triger authentication
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain auth details
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Sign In The User
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                Image.asset("images/logo.png"),
                SizedBox(height: height * 0.03),
                Text(
                  "inventory".tr(),
                  style: const TextStyle(
                      color: blueBlack,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "welcome_back".tr(),
                  style: const TextStyle(
                    color: blueBlack,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: height * 0.04),
                MyTextField(
                  controller: emailController,
                  hintText: "email".tr(),
                  obscureText: false,
                ),
                SizedBox(height: height * 0.01),
                MyTextField(
                  controller: passwordController,
                  hintText: "password".tr(),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()),
                          );
                        },
                        child: Text(
                          "forgot_password".tr(),
                          style: TextStyle(
                            color: grey500,
                            fontSize: 11,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MyButton(
                  onTap: signInUser,
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: grey700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "or_continue_with".tr(),
                          style: TextStyle(color: grey700),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: grey700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                GestureDetector(
                  onTap: () async {
                    await signInWithGoogle();
                    final storeBloc = StoreBloc();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: storeBloc,
                            child: const ParentPage(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SquareTile(imagePath: 'images/google.png'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "not_a_member".tr(),
                      style: TextStyle(color: grey700),
                    ),
                    SizedBox(width: width * 0.01),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpForm()),
                        );
                      },
                      child: Text(
                        "register_now".tr(),
                        style: const TextStyle(
                          color: orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
