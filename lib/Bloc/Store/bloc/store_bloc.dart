import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Service/ApiService.dart';
import 'package:supermarket_inventory/Service/Utility.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final _apiServiceProvider = ApiServiceProvider();

  StoreBloc() : super(StoreInitialState()) {
    on<GetDataButtonPressed>((event, emit) async {
      emit(StoreLoadingState());
      final product = await _apiServiceProvider.fetchProduct();
      emit(StoreSuccessState(product!));
    });

    on<GetCategoryButtonPressed>((event, emit) async {
      emit(StoreLoadingState());
      final product = await _apiServiceProvider.fetchProduct();
      dynamic category = [];

      //removing duplicates
      for (var p in product!) {
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
        double price = 10;
        for (var p in product) {
          if (key == p.productCategory) {
            int productPriceInt = p.productPrice;
            double productPrice = productPriceInt.toDouble();
            price += productPrice;
          }
        }

        productTotalPrice[key] = price;
      }

      //calculating the total product price
      for (var value in productTotalPrice.values) {
        totalProductPrice += value;
      }

      emit(StoreSuccessState(category));
    });
  }
}
