import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/View/Store/ProductListTile.dart';
import 'package:supermarket_inventory/View/Store/StoreManagement.dart';
import 'package:supermarket_inventory/View/Store/StorePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<StoreBloc>(
        create: (context) => StoreBloc(),
        child: StoreManagement(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: ProductListTile(
        productCategory: "Fruit",
        productImage:
            "https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c3RyYXdiZXJyeXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
        productPrice: 22,
      ),
    ));
  }
}

// BlocProvider<StoreBloc>(
//         create: (context) => StoreBloc(),
//         child: const StorePage(),