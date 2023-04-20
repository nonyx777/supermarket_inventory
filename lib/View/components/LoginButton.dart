import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: blueBlack,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: orangeAccent,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
