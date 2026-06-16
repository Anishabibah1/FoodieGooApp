import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;
  AddToCartUseCase(this.repository);
  void call(CartItemEntity item) => repository.addItem(item);
}

class RemoveFromCartUseCase {
  final CartRepository repository;
  RemoveFromCartUseCase(this.repository);
  void call(String itemName) => repository.removeItem(itemName);
}

class GetCartItemsUseCase {
  final CartRepository repository;
  GetCartItemsUseCase(this.repository);
  List<CartItemEntity> call() => repository.getCartItems();
}

class ClearCartUseCase {
  final CartRepository repository;
  ClearCartUseCase(this.repository);
  void call() => repository.clearCart();
}