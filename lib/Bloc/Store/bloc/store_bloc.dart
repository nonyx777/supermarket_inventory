import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Store/service.dart';
import 'package:supermarket_inventory/Service/ApiService.dart';
import 'package:supermarket_inventory/Service/Utility.dart';

part 'store_event.dart';
part 'store_state.dart';

final _service = Service();

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final _apiServiceProvider = ApiServiceProvider();

  StoreBloc() : super(StoreInitialState()) {
    on<GetDataButtonPressed>((event, emit) async {
      emit(StoreLoadingState());

      // final products = await _apiServiceProvider.fetchProduct();
      addedProducts.clear();
      readFromDatabase();
      final selectedProducts = [];
      for (var product in addedProducts) {
        if (product.productCategory == selectedCategory) {
          selectedProducts.add(product);
        }
      }
      emit(StoreSuccessState(selectedProducts));
    });

    on<GetCategoryButtonPressed>((event, emit) async {
      emit(StoreLoadingState());

      addedProducts.clear();
      readFromDatabase();
      final apiProduct = await _apiServiceProvider.fetchProduct();

      //checking if the db is empty
      //if so save the newly fetched products in the database
      if (addedProducts.isEmpty) {
        for (var apip in apiProduct!) {
          _service.saveProduct(apip);
        }
        readFromDatabase();
      } else {
        //adding the quantity of the same product
        for (var dbp in addedProducts) {
          for (var apip in apiProduct!) {
            double quantity = 0;
            if (dbp.id == apip.id) {
              dbp.productQuantity += apip.productQuantity;
              //updating the product in the database
              _service.updateProduct(dbp);
            }
          }
        }

        addedProducts.clear();
        readFromDatabase();
      }

      dynamic category = [];

      //removing duplicates
      for (var p in addedProducts) {
        int count = 0;
        for (var c in category) {
          if (p.productCategory == c.productCategory) {
            count++;
          }
        }
        if (count == 0) {
          category.add(p);
        }
      }

      //Adding products' categories as keys
      //getting the total price of products in the same category
      for (var c in category) {
        productTotalPrice[c.productCategory] = 0;
      }

      for (var key in productTotalPrice.keys) {
        double price = 0;
        for (var p in addedProducts) {
          if (key == p.productCategory) {
            num productPriceInt = p.productPrice;
            double productPrice = productPriceInt.toDouble();
            price += productPrice;
          }
        }

        productTotalPrice[key] = price;
      }

      totalProductPrice = 0;
      //calculating the total product price
      for (var value in productTotalPrice.values) {
        totalProductPrice += value;
      }

      emit(StoreSuccessState(category));
    });
  }
}

void readFromDatabase() {
  _service.readProduct().then((value) => productData = value);
  if (productData != null) {
    for (var i = 0; i < productData!.length; i++) {
      addedProducts.add(Product.fromJson(productData![i]));
    }
  }
}
