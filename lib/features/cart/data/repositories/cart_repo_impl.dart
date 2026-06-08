import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItemEntity> _items = [];

  @override
  List<CartItemEntity> getCartItems() => List.from(_items);

  @override
  void addItem(CartItemEntity item) {
    final index = _items.indexWhere((i) => i.name == item.name);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(qty: _items[index].qty + 1);
    } else {
      _items.add(item);
    }
  }

  @override
  void removeItem(String itemName) {
    _items.removeWhere((i) => i.name == itemName);
  }

  @override
  void clearCart() => _items.clear();

  @override
  int getTotalPrice() => _items.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  int getTotalItems() => _items.fold(0, (sum, item) => sum + item.qty);
}