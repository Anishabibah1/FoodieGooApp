import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;
  OrderRepositoryImpl(this.dataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    try {
      return await dataSource.getOrders();
    } catch (e) {
      throw Exception('Gagal mengambil riwayat pesanan: $e');
    }
  }

  @override
  Future<void> placeOrder(OrderEntity order) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}