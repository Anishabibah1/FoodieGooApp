import '../../domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.restoName,
    required super.restoImageUrl,
    required super.items,
    required super.total,
    required super.status,
    required super.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      restoName: json['restoName'] ?? '',
      restoImageUrl: json['restoImageUrl'] ?? '',
      items: List<String>.from(json['items'] ?? []),
      total: json['total'] ?? 0,
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restoName': restoName,
      'restoImageUrl': restoImageUrl,
      'items': items,
      'total': total,
      'status': status,
      'date': date,
    };
  }
}