import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: pureWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText.tr(),
            hintStyle: kMRegularStyle.copyWith(color: grey500)),
      ),
    );
  }
}
