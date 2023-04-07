import 'dart:convert';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  Future<List?> fetchProduct() async {
    final response = await http.get(
      Uri.parse(
          'https://642b0a1db11efeb759a930cb.mockapi.io/api/supermarket/products'),
      headers: <String, String>{
        'Content-Type': 'appilication/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Product.productList(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
