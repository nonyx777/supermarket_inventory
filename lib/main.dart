import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/HomePage.dart';
import 'package:supermarket_inventory/View/LoginForm.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(),
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const StoreManagement();
              } else {
                return LoginForm();
              }
            },
          ),
        ));
  }
}
