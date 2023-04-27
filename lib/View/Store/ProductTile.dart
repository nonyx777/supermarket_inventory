import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Market_Bloc/market_bloc.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Market/service.dart';
import 'package:supermarket_inventory/Service/Notification.dart';
import 'package:supermarket_inventory/Service/Utility.dart';
import 'package:supermarket_inventory/color/color.dart';
import 'package:supermarket_inventory/main.dart';

double quantity = 1;

class ProductTile extends StatefulWidget {
  final int id;
  final String productName;
  final double productPrice;
  final String productImage;
  final double productQuantity;

  const ProductTile(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productQuantity,
      super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height * 0.245,
            width: width * .9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.productImage),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: width * 0.245,
                    height: height * 0.055,
                    child: ElevatedButton(
                      onPressed: () async {
                        //instantiating an object
                        //triggering an event to save the product into the database
                        market_product = Product(
                            id: widget.id,
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                            productImage: widget.productImage,
                            productCategory: selectedCategory,
                            productQuantity: widget.productQuantity);

                        saveToMarketDatabase();
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(productTileButtonColor),
                      ),
                      child: Text(
                        "add".tr(),
                        style: kMRegularStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: pureBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.05, right: width * 0.02, top: height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.productName.tr(), style: kMBoldStyle),
                    Text("\$${widget.productPrice}",
                        style: kMSemiBoldStyle.copyWith(fontSize: 22)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available Quantity: " +
                          widget.productQuantity.toString(),
                      style: kMLightStyle.copyWith(fontSize: 14),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity < widget.productQuantity) {
                              setState(() {
                                quantity++;
                              });
                            }
                          },
                          color: blueBlack,
                          icon: const Icon(Icons.add),
                        ),
                        Text(
                          quantity.toString(),
                          style: kMRegularStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          color: blueBlack,
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//this function should be removed and added to the bloc once done....
void saveToMarketDatabase() async {
  final _service = Service(); //market service

  await readFromDatabase();
  //notify....
  await NotificationService.showNotification(
    title: "Product Added To Market",
    body: "You have added " +
        quantity.toString() +
        " amount of " +
        market_product.productName +
        " into the Market",
    notificationLayout: NotificationLayout.BigPicture,
    bigPicture: market_product.productImage,
  );

  if (marketProducts.contains(market_product)) {
    market_product.productQuantity += quantity;
    _service.updateProduct(market_product);
  } else {
    _service.saveProduct(market_product);
  }

  //decreasing quantity from the store database
  for (var product in addedProducts) {
    if (product.id == market_product.id) {
      product.productQuantity -= quantity;
      storeService.updateProduct(product);
    }
  }

  //revert quantity to 1
  quantity = 1;
}
