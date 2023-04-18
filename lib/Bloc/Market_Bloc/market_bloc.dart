import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Market/service.dart';
import 'package:supermarket_inventory/Service/Utility.dart';

part 'market_event.dart';
part 'market_state.dart';

final _service = Service();
late bool already_in_database;

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketInitial()) {
    on<MarketFetch>((event, emit) async {
      emit(MarketLoadingState());
      // final product = await _apiServiceProvider.fetchProduct();
      await readFromDatabase();
      // print(marketProducts.length);
      emit(MarketSuccessState(marketProducts));
    });

    on<MarketSave>((event, emit) async {
      emit(MarketLoadingState());
      marketProducts.clear();
      await readFromDatabase();

      //checking if the product is already in the market database
      for (var product in marketProducts) {
        if (market_product.id == product.id) {
          market_product.productQuantity += product.productQuantity;
          _service.updateProduct(market_product);
          already_in_database = true;
        }
      }

      if (!already_in_database) {
        await saveToDatabase(market_product);
        already_in_database = false;
      }
    });
  }
}

Future<Product?> saveToDatabase(Product product) async {
  await _service.saveProduct(product);
  return product;
}

Future<void> readFromDatabase() async {
  await _service.readProduct().then((value) => productData = value);
  if (productData != null) {
    for (var i = 0; i < productData!.length; i++) {
      marketProducts.add(Product.fromJson(productData![i]));
    }
  }
}
