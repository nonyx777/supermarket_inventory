import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/Service/Utility.dart';
import 'package:supermarket_inventory/View/Store/ProductTile.dart';
import 'package:supermarket_inventory/View/Store/StorePage.dart';
import 'package:supermarket_inventory/color/color.dart';

class ProductListTile extends StatefulWidget {
  final String productCategory;
  final String productImage;
  final double productPrice;

  const ProductListTile(
      {required this.productCategory,
      required this.productImage,
      required this.productPrice,
      super.key});

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height * 0.13,
        width: width * .9,
        decoration: const BoxDecoration(
          color: productTileColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.all(height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(150),
                child: Container(
                  height: width * .2,
                  width: width * .2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.productImage),
                      fit: BoxFit.fitWidth,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              //...
              SizedBox(
                width: width * 0.05,
              ),
              //..
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //...
                    SizedBox(
                      height: height * 0.01,
                    ),
                    //...
                    Text(
                      widget.productCategory.tr(),
                      style: kMBoldStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    //...
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //...
                    Text(
                      "\$${widget.productPrice.toString()}",
                      style: kMBoldStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  quantity = 1; //reverting quantity of product tile
                  selectedCategory = widget.productCategory;
                  final storeBloc = StoreBloc();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: storeBloc,
                        child: StorePage(),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.navigate_next_rounded,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
