class Product {
  int id;
  String productName;
  double productPrice;
  String productImage;
  String productCategory;

  Product(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productCategory});

  factory Product.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int productPriceInt = json['productPrice'];
    double productPrice = productPriceInt.toDouble();

    return Product(
        id: id,
        productName: json['productName'],
        productPrice: productPrice,
        productImage: json['productImage'],
        productCategory: json['productCategory']);
  }

  static List productList(List product_api) {
    List products = [];
    for (var i = 0; i < product_api.length; i++) {
      products.add(Product.fromJson(product_api[i]));
    }

    return products;
  }

  toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['productName'] = productName;
    json['productPrice'] = productPrice;
    json['productImage'] = productImage;
    json['productCategory'] = productCategory;

    return json;
  }
}
