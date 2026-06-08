import '../../domain/entities/cart_item_entity.dart';

class CartModel extends CartItemEntity {
  const CartModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.resto,
    super.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      resto: json['resto'] ?? '',
      qty: json['qty'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'resto': resto,
      'qty': qty,
    };
  }
}