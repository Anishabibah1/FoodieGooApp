import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  List<CartItemEntity> getCartItems();
  void addItem(CartItemEntity item);
  void removeItem(String itemName);
  void clearCart();
  int getTotalPrice();
  int getTotalItems();
}