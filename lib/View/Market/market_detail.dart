import 'package:flutter/material.dart';

import '../../Data/Model/Product.dart';

class MarketDetailPage extends StatefulWidget {
  final Product product;

  const MarketDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget.product.productImage,
            fit: BoxFit.cover,
            height: 300,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: const TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    '\$${widget.product.productPrice}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  const Text('Quantity'),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        _quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sell'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
