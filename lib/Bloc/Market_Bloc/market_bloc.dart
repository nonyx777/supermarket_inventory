import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_inventory/Data/Model/Product.dart';
import 'package:supermarket_inventory/Data/Repository/Market/service.dart';
import 'package:supermarket_inventory/Service/Utility.dart';

part 'market_event.dart';
part 'market_state.dart';

final _service = Service();

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketInitial()) {
    on<MarketFetch>((event, emit) async {
      emit(MarketLoadingState());
      // final product = await _apiServiceProvider.fetchProduct();
      await readFromDatabase();
      print(marketProducts.length);
      emit(MarketSuccessState(marketProducts));
    });

    on<MarketSave>((event, emit) async {
      await saveToDatabase(market_product);
    });
  }
}

Future<Product?> saveToDatabase(Product product) async {
  await _service.saveProduct(product);
  return product;
}

Future<List?> readFromDatabase() async {
  await _service.readProduct().then((value) => productData = value);
  if (productData != null) {
    for (var i = 0; i < productData!.length; i++) {
      marketProducts.add(productData![i]);
    }
  }
  return marketProducts;
}
