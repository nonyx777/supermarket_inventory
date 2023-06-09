import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: pureWhite),
        borderRadius: BorderRadius.circular(16),
        color: grey200,
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
