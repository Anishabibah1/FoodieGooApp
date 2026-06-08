import '../models/payment_model.dart';

class PaymentDataSource {
  Future<PaymentModel> processPayment({
    required String method,
    required int amount,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return PaymentModel(
      id: 'TRX-${DateTime.now().millisecondsSinceEpoch}',
      method: method,
      amount: amount,
      status: 'success',
      createdAt: DateTime.now(),
    );
  }
}