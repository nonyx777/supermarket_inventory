import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/Profile/change_password.dart';
import 'package:supermarket_inventory/View/Profile/profile_menu.dart';
import 'package:supermarket_inventory/View/Profile/profile_pic.dart';
import 'package:supermarket_inventory/View/Profile/supportedlocales.dart';
import 'package:supermarket_inventory/color/color.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  String _getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'am':
        return 'አማርኛ';
      case 'fr':
        return 'Français';
      default:
        return 'English';
    }
  }

  logoutPopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'are_you_sure'.tr(),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await googleLogout();
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                          },
                          child: Text("logout".tr()),
                          style: ElevatedButton.styleFrom(primary: dangerRed),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            ProfilePic(),
            SizedBox(height: height * 0.05),
            ListTile(
              leading: const Icon(
                Icons.language,
                color: orangeAccent,
              ),
              title: Text(
                'language'.tr(),
                style: kMRegularStyle,
              ),
              trailing: DropdownButton<Locale>(
                value: context.locale,
                onChanged: (newLocale) {
                  setState(() {
                    BlocProvider.of<StoreBloc>(context)
                        .add(GetCategoryInitially());
                    context.setLocale(newLocale!);
                  });
                },
                items: supportedLocales
                    .map((locale) => DropdownMenuItem(
                          value: locale,
                          child: Text(
                            _getLocaleDisplayName(locale),
                          ),
                        ))
                    .toList(),
              ),
            ),
            ProfileMenu(
              text: "change_password".tr(),
              icon: const Icon(Icons.change_circle, color: orangeAccent),
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
            ProfileMenu(
              text: "logout".tr(),
              icon: const Icon(
                Icons.logout,
                color: orangeAccent,
              ),
              press: () async {
                logoutPopup();
              },
            ),
          ],
        ),
      ),
    );
  }
}
