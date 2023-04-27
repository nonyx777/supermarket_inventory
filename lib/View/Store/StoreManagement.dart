import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Store/bloc/store_bloc.dart';
import 'package:supermarket_inventory/Service/Utility.dart';
import 'package:supermarket_inventory/View/Store/ProductListTile.dart';
import 'package:supermarket_inventory/color/color.dart';

class StoreManagement extends StatefulWidget {
  const StoreManagement({super.key});

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  int index = 0;

  @override
  void initState() {
    BlocProvider.of<StoreBloc>(context).add(GetCategoryInitially());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state is StoreInitialState) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 238, 242, 245),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    1,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total_product_price".tr(),
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "stock_in_hand".tr(),
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    //...
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "0",
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "0",
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    //...
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "product_list".tr(),
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              blueBlack,
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<StoreBloc>(context)
                                .add(GetCategoryButtonPressed());
                          },
                          child: Text(
                            "request".tr(),
                            style: kMRegularStyle.copyWith(
                              color: orangeAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //...
                    Center(
                      child: Text(
                        "no_available_products".tr(),
                        style: kMBoldStyle.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is StoreLoadingState) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 238, 242, 245),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    1,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(height * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total_product_price".tr(),
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "stock_in_hand".tr(),
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    //...
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "0",
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "0",
                          style: kMRegularStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    //...
                    SizedBox(
                      height: height * 0.02,
                    ),
                    //product list(scrollable)
                    Text(
                      "product_list".tr(),
                      style: kMRegularStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    //...
                    SizedBox(
                      height: height * 0.1,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is StoreFailState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is StoreSuccessState) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 238, 242, 245),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    1,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: height * 0.03,
                    right: height * 0.03), //height * 0.03
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "total_product_price".tr(),
                            style: kMLightStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "stock_in_hand".tr(),
                            style: kMLightStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      //...
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$$totalProductPrice",
                            style: kMBoldStyle.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            totalProductQuantity.toString(),
                            style: kMRegularStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      //...
                      SizedBox(
                        height: height * 0.02,
                      ),
                      //product list(scrollable)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "product_list".tr(),
                            style: kMBoldStyle.copyWith(),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                blueBlack,
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<StoreBloc>(context)
                                  .add(GetCategoryButtonPressed());
                            },
                            child: Text(
                              "request".tr(),
                              style: kMRegularStyle.copyWith(
                                  color: pureWhite, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      //....
                      SizedBox(
                        height: height * 0.02,
                      ),
                      //....

                      //display all the available categories from the database
                      for (var product in state.product)
                        Container(
                          child: Column(
                            children: [
                              ProductListTile(
                                productCategory: product.productCategory,
                                productImage: product.productImage,
                                productPrice:
                                    productTotalPrice[product.productCategory],
                              ),
                              //....
                              SizedBox(
                                height: height * 0.015,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
