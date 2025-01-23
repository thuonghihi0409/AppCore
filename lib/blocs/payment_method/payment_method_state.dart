part of 'payment_method_bloc.dart';

@immutable
class PaymentMethodState extends Equatable {
  final List<PaymentMethod> methods;
  final String? selectedMethod;
  final bool isLoading;

  PaymentMethodState({
    this.methods = const [],
    this.selectedMethod,
    this.isLoading = false,
  });

  PaymentMethodState copyWith({
    List<PaymentMethod>? methods,
    String? selectedMethod,
    bool? isLoading,
  }) {
    return PaymentMethodState(
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [methods, selectedMethod, isLoading];
}
