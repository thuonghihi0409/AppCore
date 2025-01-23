import 'package:appcore/models/paymentmethod.dart';
import 'package:appcore/utils/data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodState()) {
    on<LoadPaymentMethods>(_onLoadPaymentMethods);
    on<AddPaymentMethod>(_onAddPaymentMethod);
    on<RemovePaymentMethod>(_onRemovePaymentMethod);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
  }

  void _onLoadPaymentMethods(
      LoadPaymentMethods event, Emitter<PaymentMethodState> emit) {
    emit(state.copyWith(isLoading: true));
    Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(
        isLoading: false,
        methods: pamentmethod_data,
      ));
    });
  }

  void _onAddPaymentMethod(
      AddPaymentMethod event, Emitter<PaymentMethodState> emit) {
    final updatedMethods = List<PaymentMethod>.from(state.methods)..add(event.paymentMethod);
    emit(state.copyWith(methods: updatedMethods));
  }

  void _onRemovePaymentMethod(
      RemovePaymentMethod event, Emitter<PaymentMethodState> emit) {
    final updatedMethods =
        state.methods.where((method) => method.id != event.id).toList();
    emit(state.copyWith(methods: updatedMethods));
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<PaymentMethodState> emit) {
    emit(state.copyWith(selectedMethod: event.methodName.id));
  }
}
