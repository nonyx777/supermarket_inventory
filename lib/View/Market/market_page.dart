import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:supermarket_inventory/Bloc/Market_Bloc/market_bloc.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Service/Utility.dart';
import 'package:supermarket_inventory/View/Market/market_detail.dart';
import 'package:supermarket_inventory/View/Market/search.dart';
import 'package:supermarket_inventory/color/color.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<Product> _getFilteredProducts(List<Product> products) {
    if (selectedCategory_.isEmpty || products == null) {
      return [];
    } else if (selectedCategory_ == "all" || selectedCategory_.isEmpty) {
      return products;
    } else {
      return products
          .where((m) => m.productCategory == selectedCategory_)
          .toList();
    }
  }

  @override
  void initState() {
    BlocProvider.of<MarketBloc>(context).add(MarketFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) {
          if (state is MarketInitial) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0.2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "search".tr(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is MarketLoadingState) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0.2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "search".tr(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else if (state is MarketFailState) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0.2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "search".tr(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(state.message),
                ),
              ],
            );
          } else if (state is MarketSuccessState) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(height * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0.2,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: CustomSearch(),
                            );
                          },
                          decoration: InputDecoration(
                            hintText: "search".tr(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.065,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03, right: width * 0.03),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories_.length + 1,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: width * 0.03);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategory_ = "all";
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedCategory_ == "all"
                                      ? Colors.orangeAccent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04, vertical: 10),
                                child: Text(
                                  "all".tr(),
                                  style: kMRegularStyle.copyWith(
                                    color: selectedCategory_ == "all"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            final category = categories_[index - 1];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategory_ = category;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedCategory_ == category
                                      ? Colors.orangeAccent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  category.tr(),
                                  style: kMRegularStyle.copyWith(
                                    color: selectedCategory_ == category
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: _getFilteredProducts(state.product).length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.75),
                      itemBuilder: (BuildContext context, int index) {
                        final product =
                            _getFilteredProducts(state.product)[index];
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
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.network(
                                  product.productImage,
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.008,
                                      ),
                                      Text(
                                        product.productName.tr(),
                                        style: kMSemiBoldStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                      SizedBox(height: height * 0.005),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${product.productPrice}',
                                            style: kMRegularStyle.copyWith(
                                                fontSize: 16),
                                          ),
                                          Text(
                                            '${product.productQuantity}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
