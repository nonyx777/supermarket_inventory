import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_inventory/color/color.dart';

import '../../Data/Model/Product.dart';

import 'package:http/http.dart' as http;

class MarketDetailPage extends StatefulWidget {
  final Product product;

  const MarketDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  List<Product> _products = [];
  List<String> _categories = [];
  String _selectedCategory = "all";

  int _quantity = 1;

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://642b0a1db11efeb759a930cb.mockapi.io/api/supermarket/products'));
    final List<Product> fetchedProducts = [];

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      for (var json in productsJson) {
        final product = Product.fromJson(json);
        fetchedProducts.add(product);
        _selectedCategory = 'all';
      }
    }

    setState(() {
      _products = fetchedProducts;
      _categories = _products.map((p) => p.productCategory).toSet().toList();
    });
  }

  List<Product> _getFilteredProducts() {
    if (_selectedCategory.isEmpty || _products == null) {
      return [];
    } else if (_selectedCategory == "all" || _selectedCategory.isEmpty) {
      return _products;
    } else {
      return _products
          .where((p) => p.productCategory == _selectedCategory)
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _selectedCategory = "all";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName.tr(),
          style: kMBoldStyle,
        ),
        backgroundColor: const Color.fromARGB(255, 20, 33, 61),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.productName.tr(),
                        style: kMBoldStyle.copyWith(fontSize: 20),
                      ),
                      Text(
                        '\$${widget.product.productPrice}',
                        style: kMBoldStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_quantity >= 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromARGB(255, 20, 33, 61),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Text(_quantity.toString()),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromARGB(255, 20, 33, 61),
                          child: Icon(Icons.add),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.42,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 20, 33, 61)),
                              fixedSize: MaterialStateProperty.all(
                                  Size(double.infinity, height * 0.06)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)))),
                          child: Text(
                            "sell".tr(),
                            style: kMSemiBoldStyle.copyWith(fontSize: 15),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "items".tr(),
                    style: kMRegularStyle.copyWith(fontSize: 20),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: _getFilteredProducts().length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final product = _getFilteredProducts()[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MarketDetailPage(product: product),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 11, vertical: 5),
                                          color: Colors.white,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        product.productImage))),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                          ),
                                        ),
                                        Text(
                                          product.productName.tr(),
                                          style: kMLightStyle.copyWith(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.015,
                                        ),
                                        Text(
                                          '\$${product.productPrice}',
                                          style: kMLightStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
