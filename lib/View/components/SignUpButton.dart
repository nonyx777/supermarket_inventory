import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final Function()? onTap;

  const SignUpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 33, 61),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "SIGN UP",
            style: TextStyle(
              color: Color.fromARGB(255, 252, 163, 17),
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
