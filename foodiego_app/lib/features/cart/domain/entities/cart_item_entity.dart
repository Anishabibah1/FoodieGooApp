class CartItemEntity {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final String resto;
  final int qty;

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.resto,
    this.qty = 1,
  });

  CartItemEntity copyWith({int? qty}) {
    return CartItemEntity(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      resto: resto,
      qty: qty ?? this.qty,
    );
  }

  int get totalPrice => price * qty;
}