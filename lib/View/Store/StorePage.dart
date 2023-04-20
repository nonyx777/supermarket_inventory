import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/View/Store/ProductTile.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    BlocProvider.of<StoreBloc>(context).add(GetDataButtonPressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: const Color.fromARGB(255, 20, 33, 61),
      ),
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreInitialState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: const Text("No prodcuts available"),
            );
          } else if (state is StoreLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StoreFailState) {
            return Text(state.message);
          } else if (state is StoreSuccessState) {
            return ListView.builder(
              itemCount: state.product.length,
              itemBuilder: (context, index) {
                final Product product = state.product[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Column(
                    children: [
                      ProductTile(
                        id: product.id,
                        productName: product.productName,
                        productPrice: product.productPrice,
                        productImage: product.productImage,
                        productQuantity: product.productQuantity,
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
