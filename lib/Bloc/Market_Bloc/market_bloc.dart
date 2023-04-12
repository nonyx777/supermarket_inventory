import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Service/ApiService.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final _apiServiceProvider = ApiServiceProvider();

  MarketBloc() : super(MarketInitial()) {
    on<MarketFetch>((event, emit) async {
      emit(MarketLoadingState());
      final product = await _apiServiceProvider.fetchProduct();
      emit(MarketSuccessState(product!));
    });
  }
}
