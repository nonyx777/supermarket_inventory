import 'package:flutter/material.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/main.dart';

class ProductTile extends StatefulWidget {
  final int id;
  final String productName;
  final double productPrice;
  final String productImage;

  const ProductTile(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 200,
        width: width * .9,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.productImage),
            fit: BoxFit.fitWidth,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                              ..color = Colors.white),
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
                              ..color = Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 252, 248, 248)),
                  ),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}