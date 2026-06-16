import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// MODEL
class CartItem extends Equatable {
  final String name;
  final int price;
  final String imageUrl;
  final String resto;
  final int qty;

  const CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.resto,
    this.qty = 1,
  });

  CartItem copyWith({int? qty}) {
    return CartItem(
      name: name,
      price: price,
      imageUrl: imageUrl,
      resto: resto,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object> get props => [name, price, imageUrl, resto, qty];
}

// EVENTS
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final CartItem item;
  AddToCartEvent(this.item);
  @override
  List<Object> get props => [item];
}

class DecrementQtyEvent extends CartEvent {
  final String itemName;
  DecrementQtyEvent(this.itemName);
  @override
  List<Object> get props => [itemName];
}

class RemoveFromCartEvent extends CartEvent {
  final String itemName;
  RemoveFromCartEvent(this.itemName);
  @override
  List<Object> get props => [itemName];
}

class ClearCartEvent extends CartEvent {}

// STATES
abstract class CartState extends Equatable {
  final List<CartItem> items;
  const CartState(this.items);

  int get totalItems => items.fold(0, (sum, item) => sum + item.qty);
  int get totalPrice => items.fold(0, (sum, item) => sum + item.price * item.qty);

  @override
  List<Object> get props => [items];
}

class CartInitial extends CartState {
  const CartInitial() : super(const []);
}

class CartUpdated extends CartState {
  const CartUpdated(super.items);
}

// BLOC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<AddToCartEvent>((event, emit) {
      final items = List<CartItem>.from(state.items);
      final index = items.indexWhere((i) => i.name == event.item.name);
      if (index >= 0) {
        items[index] = items[index].copyWith(qty: items[index].qty + 1);
      } else {
        items.add(event.item);
      }
      emit(CartUpdated(items));
    });

    on<DecrementQtyEvent>((event, emit) {
      final items = List<CartItem>.from(state.items);
      final index = items.indexWhere((i) => i.name == event.itemName);
      if (index >= 0) {
        if (items[index].qty <= 1) {
          items.removeAt(index);
        } else {
          items[index] = items[index].copyWith(qty: items[index].qty - 1);
        }
      }
      emit(CartUpdated(items));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final items = state.items
          .where((i) => i.name != event.itemName)
          .toList();
      emit(CartUpdated(items));
    });

    on<ClearCartEvent>((event, emit) {
      emit(const CartInitial());
    });
  }
}