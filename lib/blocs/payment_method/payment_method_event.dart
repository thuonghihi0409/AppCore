part of 'payment_method_bloc.dart';

@immutable
abstract class PaymentMethodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPaymentMethods extends PaymentMethodEvent {}

class AddPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod; 

  AddPaymentMethod( {required this.paymentMethod});

  @override
  List<Object?> get props => [paymentMethod];
}

class RemovePaymentMethod extends PaymentMethodEvent {
  final String id;

  RemovePaymentMethod({required this.id});

  @override
  List<Object?> get props => [id];
}

class SelectPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod methodName;

  SelectPaymentMethod({required this.methodName});

  @override
  List<Object?> get props => [methodName];
}
