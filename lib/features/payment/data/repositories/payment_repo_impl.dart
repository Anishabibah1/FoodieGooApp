import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDataSource dataSource;
  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<PaymentEntity> processPayment({
    required String method,
    required int amount,
  }) async {
    try {
      return await dataSource.processPayment(
        method: method,
        amount: amount,
      );
    } catch (e) {
      throw Exception('Gagal memproses pembayaran: $e');
    }
  }
}