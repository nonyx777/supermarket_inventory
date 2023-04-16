part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {}

class GetDataButtonPressed extends StoreEvent {
  @override
  List<Object> get props => [];
}

class GetCategoryButtonPressed extends StoreEvent {
  @override
  List<Object> get props => [];
}

class GetCategoryInitially extends StoreEvent {
  @override
  List<Object> get props => [];
}