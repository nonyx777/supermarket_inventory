import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Store/service.dart';

//related with the store
List<String> categoryExists = [];
Map<String, dynamic> productTotalPrice = {};
Map<String, dynamic> productTotalInCategory = {};
double totalProductPrice = 0;
double totalProductQuantity = 0;
String selectedCategory = "";
List<Map<String, dynamic>>? productData;
List addedProducts = [];
Service storeService = Service();

//related with the market
late Product market_product;
List<Product> marketProducts = [];
List<Product> products_ = [];
List<String> categories_ = [];
String selectedCategory_ = 'all';
