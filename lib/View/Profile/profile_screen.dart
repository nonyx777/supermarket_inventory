import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/Profile/change_notifier.dart';
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
  // final LanguageNotifier _languageNotifier = LanguageNotifier();

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
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
              ),
              trailing: DropdownButton<Locale>(
                value: context.locale,
                onChanged: (newLocale) {
                  BlocProvider.of<StoreBloc>(context)
                      .add(GetCategoryInitially());
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
                            locale.languageCode.toUpperCase(),
                          ),
                        ))
                    .toList(),
              ),
              onTap: () {
                context.setLocale(Locale(''));
              },
            ),
            ProfileMenu(
              text: "change_password".tr(),
              icon: const Icon(Icons.change_circle, color: orangeAccent),
              press: () {
                Navigator.pushReplacement(context,
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
                await googleLogout();
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
