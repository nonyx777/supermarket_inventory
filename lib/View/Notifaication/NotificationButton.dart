import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: onPressed,
          child: Text(
            text,
            style: kMBoldStyle,
          ).tr(),
        ),
      ),
    );
  }
}
