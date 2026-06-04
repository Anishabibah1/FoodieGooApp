import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String category;
  final String rating;
  final String time;
  final String emoji;

  const DetailPage({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.time,
    required this.emoji,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Map<String, int> _cartItems = {};
  int _selectedCategory = 0;

  final List<String> _menuCategories = ['Semua', 'Makanan', 'Minuman', 'Snack'];

  final List<Map<String, dynamic>> _menuItems = [
    {'name': 'Nasi Goreng Spesial', 'desc': 'Nasi goreng dengan telur, ayam, dan sayuran', 'price': 25000, 'emoji': '🍳', 'category': 'Makanan'},
    {'name': 'Ayam Bakar', 'desc': 'Ayam bakar bumbu kecap dengan lalapan', 'price': 30000, 'emoji': '🍗', 'category': 'Makanan'},
    {'name': 'Mie Goreng', 'desc': 'Mie goreng dengan topping lengkap', 'price': 22000, 'emoji': '🍜', 'category': 'Makanan'},
    {'name': 'Es Teh Manis', 'desc': 'Teh manis dingin segar', 'price': 8000, 'emoji': '🧋', 'category': 'Minuman'},
    {'name': 'Jus Alpukat', 'desc': 'Jus alpukat segar dengan susu', 'price': 15000, 'emoji': '🥤', 'category': 'Minuman'},
    {'name': 'Kentang Goreng', 'desc': 'Kentang goreng crispy dengan saus', 'price': 18000, 'emoji': '🍟', 'category': 'Snack'},
    {'name': 'Pisang Goreng', 'desc': 'Pisang goreng crispy dengan keju', 'price': 12000, 'emoji': '🍌', 'category': 'Snack'},
  ];

  int get _totalItems => _cartItems.values.fold(0, (a, b) => a + b);
  int get _totalPrice => _cartItems.entries.fold(0, (total, entry) {
    final item = _menuItems.firstWhere((m) => m['name'] == entry.key);
    return total + (item['price'] as int) * entry.value;
  });

  List<Map<String, dynamic>> get _filteredMenu {
    if (_selectedCategory == 0) return _menuItems;
    final cat = _menuCategories[_selectedCategory];
    return _menuItems.where((m) => m['category'] == cat).toList();
  }

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(child: _buildRestaurantInfo()),
              SliverToBoxAdapter(child: _buildCategoryFilter()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _buildMenuItem(_filteredMenu[i]),
                  childCount: _filteredMenu.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          if (_totalItems > 0) _buildCartButton(),
        ],
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
        background: Container(
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

  Widget _buildCategoryFilter() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _menuCategories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final selected = _selectedCategory == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
                ),
                child: Text(
                  _menuCategories[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    final count = _cartItems[item['name']] ?? 0;
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
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(item['emoji'], style: const TextStyle(fontSize: 36))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(item['desc'], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(_formatPrice(item['price']), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          count == 0
              ? GestureDetector(
                  onTap: () => setState(() => _cartItems[item['name']] = 1),
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
                      onTap: () => setState(() {
                        if (count == 1) _cartItems.remove(item['name']);
                        else _cartItems[item['name']] = count - 1;
                      }),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.remove, color: AppColors.primary, size: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('$count', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _cartItems[item['name']] = count + 1),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildCartButton() {
    return Positioned(
      bottom: 16,
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(6)),
                child: Text('$_totalItems item', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              const Text('Lihat Keranjang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              Text(_formatPrice(_totalPrice), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}