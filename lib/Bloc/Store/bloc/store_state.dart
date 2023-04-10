part of 'store_bloc.dart';

abstract class StoreState extends Equatable {}

class StoreInitialState extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoadingState extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreSuccessState extends StoreState {
  final List product;

  StoreSuccessState(
    this.product,
  );

  @override
  List<Object> get props => [];
}

class StoreFailState extends StoreState {
  String message = "Failed to load products";

  StoreFailState(this.message);

  @override
  List<Object> get props => [];
}
