import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Market_Bloc/market_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/Service/Notification.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/Navigation/ParentPage.dart';
import 'package:supermarket_inventory/View/Profile/change_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final languageNotifier = LanguageNotifier();
  await languageNotifier.loadSelectedLanguage();

  runApp(
    ChangeNotifierProvider<LanguageNotifier>(
        create: (context) => LanguageNotifier(),
        builder: (context, child) {
          return EasyLocalization(
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('am', 'ETH'),
                Locale('fr', 'FR')
              ],
              path: 'assets/translations',
              fallbackLocale: const Locale('en', 'US'),
              child: const MyApp());
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(),
          child: BlocProvider<MarketBloc>(
            create: (context) => MarketBloc(),
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const ParentPage();
                } else {
                  return LoginForm();
                }
              },
            ),
          ),
        ));
  }
}
