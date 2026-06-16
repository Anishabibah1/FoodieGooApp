import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class PaymentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectPaymentMethodEvent extends PaymentEvent {
  final String method;
  SelectPaymentMethodEvent(this.method);
  @override
  List<Object> get props => [method];
}

class ProcessPaymentEvent extends PaymentEvent {
  final int amount;
  final String method;
  ProcessPaymentEvent({required this.amount, required this.method});
  @override
  List<Object> get props => [amount, method];
}

// STATES
abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentMethodSelected extends PaymentState {
  final String method;
  PaymentMethodSelected(this.method);
  @override
  List<Object> get props => [method];
}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String transactionId;
  PaymentSuccess(this.transactionId);
  @override
  List<Object> get props => [transactionId];
}

class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);
  @override
  List<Object> get props => [message];
}

// BLOC
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<SelectPaymentMethodEvent>((event, emit) {
      emit(PaymentMethodSelected(event.method));
    });

    on<ProcessPaymentEvent>((event, emit) async {
      emit(PaymentLoading());
      await Future.delayed(const Duration(seconds: 2));
      // Simulasi proses pembayaran
      final transactionId = 'TRX-${DateTime.now().millisecondsSinceEpoch}';
      emit(PaymentSuccess(transactionId));
    });
  }
}