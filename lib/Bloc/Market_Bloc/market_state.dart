part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();
  
  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {
  @override
  List<Object> get props => []; 
}

class MarketLoadingState extends MarketState {
  @override
  List<Object> get props => [];
}

class MarketSuccessState extends MarketState {
  final List product;

  const MarketSuccessState(
    this.product,
  );

  @override
  List<Object> get props => [];
}

class MarketFailState extends MarketState {
  String message = "Failed to load products";

  MarketFailState(this.message);

  @override
  List<Object> get props => [];
}
