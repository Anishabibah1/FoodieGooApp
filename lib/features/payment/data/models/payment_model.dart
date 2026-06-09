import '../../domain/entities/payment.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.method,
    required super.amount,
    required super.status,
    required super.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] ?? '',
      method: json['method'] ?? '',
      amount: json['amount'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method,
      'amount': amount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}