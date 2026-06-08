import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<PaymentEntity> processPayment({
    required String method,
    required int amount,
  });
}