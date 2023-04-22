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
      marketProducts.clear();
      await readFromDatabase();
      products_ = marketProducts;
      categories_ = products_.map((p) => p.productCategory).toSet().toList();
      selectedCategory_ = 'all';
      emit(MarketSuccessState(marketProducts));
    });

    on<MarketSave>((event, emit) async {
      emit(MarketLoadingState());
      marketProducts.clear();
      await readFromDatabase();

      await saveToDatabase(market_product);
    });
  }
}

Future<Product?> saveToDatabase(Product product) async {
  await _service.saveProduct(product);
  return product;
}

Future<List?> readFromDatabase() async {
  marketProducts.clear();
  await _service.readProduct().then((value) => productData = value);
  if (productData != null) {
    for (var i = 0; i < productData!.length; i++) {
      marketProducts.add(Product.fromJson(productData![i]));
    }
  }
  return marketProducts;
}
