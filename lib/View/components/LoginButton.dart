import 'package:easy_localization/easy_localization.dart';
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
        child: Center(
          child: Text(
            "ulogin".tr(),
            style: kMBoldStyle.copyWith(
              color: orangeAccent,
            ),
          ),
        ),
      ),
    );
  }
}
