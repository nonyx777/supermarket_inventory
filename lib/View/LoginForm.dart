import 'package:flutter/material.dart';

import 'package:supermarket_inventory/View/components/LoginButton.dart';
import 'package:supermarket_inventory/View/components/LoginTextfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              'Welcome back you, Manager',
              style: TextStyle(
                color: Color.fromARGB(255, 20, 33, 61),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller: emailController,
              hintText: 'email',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 10),
            MyButton(onTap: () {}),
          ]),
        ),
      ),
    );
  }
}
