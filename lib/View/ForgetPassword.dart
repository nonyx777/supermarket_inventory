import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/components/LoginTextfield.dart';
import 'package:supermarket_inventory/color/color.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final forgotPasswordController = TextEditingController();

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
                    Image.asset("assets/images/logo.png"),
                    Text(
                      "inventory".tr(),
                      style: kMBoldStyle.copyWith(
                          color: blueBlack,
                          fontSize: 46,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      "forgot_password".tr(),
                      style: kMSemiBoldStyle.copyWith(
                        color: blueBlack,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    MyTextField(
                      controller: forgotPasswordController,
                      hintText: "email".tr(),
                      obscureText: false,
                    ),
                    SizedBox(height: height * 0.015),
                    GestureDetector(
                      onTap: () async {
                        var forgotEmail = forgotPasswordController.text.trim();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgotEmail)
                              .then((value) => {
                                    Fluttertoast.showToast(
                                        msg: "email_sent".tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: dangerRed,
                                        textColor: pureWhite),
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginForm()),
                                    ),
                                  });
                        } on FirebaseAuthException catch (e) {
                          Fluttertoast.showToast(
                              msg: "error_try_again".tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: dangerRed,
                              textColor: pureWhite);
                        }
                        Navigator.pop(context);
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
                            "send_verification".tr(),
                            style: kMBoldStyle.copyWith(
                              color: orangeAccent,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "remember_your_password".tr(),
                          style: kMRegularStyle.copyWith(color: grey700),
                        ),
                        SizedBox(width: width * 0.01),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginForm()),
                            );
                          },
                          child: Text(
                            "login_now".tr(),
                            style: kMRegularStyle.copyWith(
                              color: orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
