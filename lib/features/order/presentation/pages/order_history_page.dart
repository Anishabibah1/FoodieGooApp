import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {
      'id': '#FG-001',
      'resto': 'Warung Nasi Padang',
      'items': 'Nasi Goreng Spesial, Es Teh Manis',
      'total': 33000,
      'status': 'Selesai',
      'date': '04 Jun 2026',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/sytuqu1511786590.jpg',
    },
    {
      'id': '#FG-002',
      'resto': 'Burger Kuy!',
      'items': 'Burger Spesial, Kentang Goreng',
      'total': 45000,
      'status': 'Selesai',
      'date': '03 Jun 2026',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg',
    },
    {
      'id': '#FG-003',
      'resto': 'Pizza Hut Express',
      'items': 'Pizza Margherita',
      'total': 75000,
      'status': 'Dibatalkan',
      'date': '01 Jun 2026',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg',
    },
  ];

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) => _buildOrderCard(_orders[i]),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final isSelesai = order['status'] == 'Selesai';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      order['imageUrl'],
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 42,
                        height: 42,
                        color: AppColors.primaryLight,
                        child: const Icon(Icons.fastfood, color: AppColors.primary, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['resto'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        order['id'],
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelesai ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelesai ? AppColors.success : AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1),
          ),
          Text(
            order['items'],
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['date'],
                style: const TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
              Text(
                _formatPrice(order['total']),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          if (isSelesai) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text(
                  'Pesan Lagi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}