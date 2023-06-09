import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supermarket_inventory/View/Market/market_page.dart';
import 'package:supermarket_inventory/View/Profile/profile_screen.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';
import 'package:supermarket_inventory/color/color.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  double height = 0;
  double width = 0;
  int page = 0;

  Future<void> googleLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  logoutPopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'are_you_sure'.tr(),
                      style: kMRegularStyle.copyWith(
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Widget child = const StoreManagement();

    switch (page) {
      case 0:
        child = const StoreManagement();
        break;
      case 1:
        child = const MarketPage();
        break;
      case 2:
        child = ProfileScreen();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueBlack,
        title: Text(
          style: kMBoldStyle.copyWith(
            color: pureWhite,
            fontSize: 25,
          ),
          "inventory".tr(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                logoutPopup();
              },
              icon: Icon(
                Icons.logout_rounded,
                size: height * 0.035,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: child,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(
            Icons.store,
            size: 30,
            color: pureWhite,
          ),
          Icon(Icons.shopping_cart_outlined, size: 30, color: pureWhite),
          Icon(Icons.perm_identity, size: 30, color: pureWhite),
        ],
        color: blueBlack,
        buttonBackgroundColor: orangeAccent,
        backgroundColor: pureWhite,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
