import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/menu_bloc.dart';

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;
  final String restoName;
  final CartBloc cartBloc;

  const MenuItemWidget({
    super.key,
    required this.item,
    required this.restoName,
    required this.cartBloc,
  });

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, cartState) {
        final cartItem = cartState.items.where((c) => c.name == item.name).toList();
        final count = cartItem.isNotEmpty ? cartItem.first.qty : 0;

        return Container(
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 70,
                    height: 70,
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Icon(Icons.fastfood, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.category,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatPrice(item.price),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              count == 0
                  ? GestureDetector(
                      onTap: () => cartBloc.add(
                        AddToCartEvent(CartItem(
                          name: item.name,
                          price: item.price,
                          imageUrl: item.imageUrl,
                          resto: restoName,
                        )),
                      ),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () => cartBloc.add(DecrementQtyEvent(item.name)),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.remove, color: AppColors.primary, size: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '$count',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => cartBloc.add(
                            AddToCartEvent(CartItem(
                              name: item.name,
                              price: item.price,
                              imageUrl: item.imageUrl,
                              resto: restoName,
                            )),
                          ),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}