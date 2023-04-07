import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket_inventory/Service/ApiService.dart';

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
  }
}
