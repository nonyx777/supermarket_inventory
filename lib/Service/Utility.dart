import 'package:supermarket_inventory/Data/Model/Product.dart';

//related with the store
List<String> categoryExists = [];
Map<String, dynamic> productTotalPrice = {};
Map<String, dynamic> productTotalInCategory = {};
double totalProductPrice = 0;
double totalProductQuantity = 0;
String selectedCategory = "";
List<Map<String, dynamic>>? productData;
List addedProducts = [];

//related with the market
late Product market_product;
List<Product> marketProducts = [];