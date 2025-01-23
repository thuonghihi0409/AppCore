part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final String name;
  final double price;

  AddProduct({required this.name, required this.price});

  @override
  List<Object?> get props => [name, price];
}

class UpdateProduct extends ProductEvent {
  final int id;
  final String name;
  final double price;

  UpdateProduct({required this.id, required this.name, required this.price});

  @override
  List<Object?> get props => [id, name, price];
}

class DeleteProduct extends ProductEvent {
  final int id;

  DeleteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

class FavariteProduct extends ProductEvent {
  final String id;

  FavariteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

class UnFavariteProduct extends ProductEvent {
  final String id;

  UnFavariteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

class CheckFavariteProduct extends ProductEvent {
  final String id;

  CheckFavariteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectProduct extends ProductEvent {
  final int id;

  SelectProduct({required this.id});

  @override
  List<Object?> get props => [id];
}
