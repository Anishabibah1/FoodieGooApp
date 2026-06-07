import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../bloc/menu_bloc.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String category;
  final String rating;
  final String time;
  final String emoji;
  final String imageUrl;

  const DetailPage({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.time,
    required this.emoji,
    this.imageUrl = '',
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late MenuBloc _menuBloc;
  late CartBloc _cartBloc;

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  void initState() {
    super.initState();
    _menuBloc = sl<MenuBloc>()..add(LoadMenuEvent(widget.name));
    _cartBloc = sl<CartBloc>();
  }

  @override
  void dispose() {
    _menuBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _menuBloc),
        BlocProvider.value(value: _cartBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(child: _buildRestaurantInfo()),
                SliverToBoxAdapter(child: _buildMenuTitle()),
                _buildMenuList(),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            _buildCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: widget.imageUrl.isNotEmpty
            ? Image.network(widget.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primaryLight,
                  child: Center(child: Text(widget.emoji, style: const TextStyle(fontSize: 80))),
                ))
            : Container(
                color: AppColors.primaryLight,
                child: Center(child: Text(widget.emoji, style: const TextStyle(fontSize: 80))),
              ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(widget.category, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Row(
            children: [
              _infoChip(Icons.star, widget.rating, Colors.amber),
              const SizedBox(width: 12),
              _infoChip(Icons.access_time, widget.time, AppColors.primary),
              const SizedBox(width: 12),
              _infoChip(Icons.delivery_dining, 'Gratis ongkir', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMenuTitle() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text('Menu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildMenuList() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state is MenuLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
          );
        } else if (state is MenuLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _buildMenuItem(context, state.items[i]),
              childCount: state.items.length,
            ),
          );
        } else if (state is MenuError) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 40, color: AppColors.textHint),
                    const SizedBox(height: 8),
                    Text(state.message, style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return BlocBuilder<CartBloc, CartState>(
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
                  width: 70, height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70, height: 70,
                    color: AppColors.primaryLight,
                    child: const Center(child: Icon(Icons.fastfood, color: AppColors.primary)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(item.category, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Text(_formatPrice(item.price), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              count == 0
                  ? GestureDetector(
                      onTap: () => _cartBloc.add(
                        AddToCartEvent(CartItem(
                          name: item.name,
                          price: item.price,
                          emoji: '🍽️',
                          resto: widget.name,
                        )),
                      ),
                      child: Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () => _cartBloc.add(DecrementQtyEvent(item.name)),
                          child: Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.remove, color: AppColors.primary, size: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('$count', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        GestureDetector(
                          onTap: () => _cartBloc.add(
                            AddToCartEvent(CartItem(
                              name: item.name,
                              price: item.price,
                              emoji: '🍽️',
                              resto: widget.name,
                            )),
                          ),
                          child: Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
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

  Widget _buildCartButton() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        if (cartState.totalItems == 0) return const SizedBox.shrink();
        return Positioned(
          bottom: 16, left: 20, right: 20,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BlocProvider.value(
                value: _cartBloc,
                child: const CartPage(),
              )),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('${cartState.totalItems} item', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  const Text('Lihat Keranjang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(_formatPrice(cartState.totalPrice), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}