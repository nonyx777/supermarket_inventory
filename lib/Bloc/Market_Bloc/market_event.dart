part of 'market_bloc.dart';


abstract class MarketEvent extends Equatable {}

class MarketFetch extends MarketEvent {
  @override
  List<Object> get props => [];
}
