import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../payment/presentation/pages/payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {'name': 'Nasi Goreng Spesial', 'price': 25000, 'qty': 1, 'emoji': '🍳', 'resto': 'Warung Nasi Padang'},
    {'name': 'Es Teh Manis', 'price': 8000, 'qty': 2, 'emoji': '🧋', 'resto': 'Warung Nasi Padang'},
    {'name': 'Ayam Bakar', 'price': 30000, 'qty': 1, 'emoji': '🍗', 'resto': 'Warung Nasi Padang'},
  ];

  int get _subtotal => _cartItems.fold(0, (sum, item) => sum + (item['price'] as int) * (item['qty'] as int));
  int get _ongkir => 5000;
  int get _total => _subtotal + _ongkir;

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Keranjang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: _cartItems.isEmpty ? _buildEmpty() : _buildCart(),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text('Keranjang kosong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Yuk tambahkan makanan favoritmu!', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(minimumSize: const Size(180, 48)),
            child: const Text('Pesan Sekarang'),
          ),
        ],
      ),
    );
  }

  Widget _buildCart() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Info restoran
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.store_outlined, color: AppColors.primary),
                    ),
                    const SizedBox(width: 10),
                    const Text('Warung Nasi Padang', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // List item
              ...(_cartItems.map((item) => _buildCartItem(item)).toList()),
              const SizedBox(height: 12),
              // Catatan
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.note_outlined, color: AppColors.textSecondary),
                    SizedBox(width: 10),
                    Text('Tambah catatan untuk restoran...', style: TextStyle(color: AppColors.textHint, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Ringkasan harga
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    _buildPriceRow('Subtotal', _formatPrice(_subtotal)),
                    const SizedBox(height: 8),
                    _buildPriceRow('Ongkos kirim', _formatPrice(_ongkir)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1),
                    ),
                    _buildPriceRow('Total', _formatPrice(_total), isTotal: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Tombol checkout
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PaymentPage(total: _total)),
            ),
            child: Text('Lanjut Pembayaran • ${_formatPrice(_total)}'),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(item['emoji'], style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 4),
                Text(_formatPrice(item['price']), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 13)),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  if (item['qty'] == 1) _cartItems.remove(item);
                  else item['qty']--;
                }),
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.remove, color: AppColors.primary, size: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('${item['qty']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              GestureDetector(
                onTap: () => setState(() => item['qty']++),
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
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: isTotal ? 15 : 13, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? AppColors.textPrimary : AppColors.textSecondary)),
        Text(value, style: TextStyle(fontSize: isTotal ? 15 : 13, fontWeight: FontWeight.bold, color: isTotal ? AppColors.primary : AppColors.textPrimary)),
      ],
    );
  }
}