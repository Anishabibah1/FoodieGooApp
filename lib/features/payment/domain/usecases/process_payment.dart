import '../entities/payment.dart';
import '../repositories/payment_repository.dart';

class ProcessPaymentUseCase {
  final PaymentRepository repository;
  ProcessPaymentUseCase(this.repository);

  Future<PaymentEntity> call({
    required String method,
    required int amount,
  }) async {
    return await repository.processPayment(
      method: method,
      amount: amount,
    );
  }
}