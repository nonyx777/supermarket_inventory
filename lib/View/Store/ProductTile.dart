import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_inventory/Bloc/Market_Bloc/market_bloc.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Market/service.dart';
import 'package:supermarket_inventory/Service/Notification.dart';
import 'package:supermarket_inventory/Service/Utility.dart';
import 'package:supermarket_inventory/color/color.dart';
import 'package:supermarket_inventory/main.dart';

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
  double quantity = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 0.2
                              ..color = pureWhite),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Text(
                        "\$${widget.productPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "\$${widget.productPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 0.2
                              ..color = pureWhite),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        icon: const Icon(Icons.add),
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
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
                        icon: const Icon(Icons.remove),
                      )
                    ],
                  ),
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
                        await NotificationService.showNotification(
                          title: "Product Added",
                          body: "You have added " +
                              quantity.toString() +
                              " amount of " +
                              widget.productName +
                              " into the Market",
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(productTileButtonColor),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: pureBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void saveToMarketDatabase() async {
  final _service = Service();

  if (marketProducts.contains(market_product)) {
    market_product.productQuantity += market_product.productQuantity;
    _service.updateProduct(market_product);
  } else {
    _service.saveProduct(market_product);
  }
}
