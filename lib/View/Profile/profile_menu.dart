import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: pureWhite,
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: width * 0.07),
            Expanded(
              child: Text(
                text.tr(),
                style: kMRegularStyle.copyWith(color: blueBlack),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
