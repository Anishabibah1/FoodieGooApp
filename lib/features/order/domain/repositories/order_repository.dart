import '../entities/order.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders();
  Future<void> placeOrder(OrderEntity order);
}