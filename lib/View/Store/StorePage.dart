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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreInitialState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  elevation: 20,
                ),
                onPressed: () {
                  BlocProvider.of<StoreBloc>(context)
                      .add(GetDataButtonPressed());
                },
                child: const Text("Products"),
              ),
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
                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.0175,
                    ),
                    ProductTile(
                      id: product.id,
                      productName: product.productName,
                      productPrice: product.productPrice,
                      productImage: product.productImage,
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
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
