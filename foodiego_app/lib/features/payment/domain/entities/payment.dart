class PaymentEntity {
  final String id;
  final String method;
  final int amount;
  final String status;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.method,
    required this.amount,
    required this.status,
    required this.createdAt,
  });
}