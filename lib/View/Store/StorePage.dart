import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/View/Store/ProductTile.dart';
import 'package:supermarket_inventory/color/color.dart';

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
        title: Text(
          "products".tr(),
          style: const TextStyle(
            color: pureWhite,
          ),
        ),
        backgroundColor: blueBlack,
      ),
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreInitialState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text("no_available_products".tr()),
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
