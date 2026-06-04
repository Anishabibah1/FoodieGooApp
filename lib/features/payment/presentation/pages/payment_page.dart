import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../pages/payment_success_page.dart';

class PaymentPage extends StatefulWidget {
  final int total;
  const PaymentPage({super.key, required this.total});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedMethod = 0;

  final List<Map<String, dynamic>> _methods = [
    {'name': 'COD (Bayar di Tempat)', 'icon': Icons.payments_outlined, 'desc': 'Bayar langsung ke driver'},
    {'name': 'Transfer Bank', 'icon': Icons.account_balance_outlined, 'desc': 'BCA, Mandiri, BNI, BRI'},
    {'name': 'GoPay', 'icon': Icons.account_balance_wallet_outlined, 'desc': 'Dompet digital GoPay'},
    {'name': 'OVO', 'icon': Icons.account_balance_wallet_outlined, 'desc': 'Dompet digital OVO'},
    {'name': 'Dana', 'icon': Icons.account_balance_wallet_outlined, 'desc': 'Dompet digital Dana'},
  ];

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pilih Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text('Metode Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...(_methods.asMap().entries.map((e) => _buildMethodTile(e.key, e.value)).toList()),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Subtotal', _formatPrice(widget.total - 5000)),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Ongkos kirim', 'Rp 5.000'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(height: 1),
                      ),
                      _buildSummaryRow('Total Bayar', _formatPrice(widget.total), isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PaymentSuccessPage()),
              ),
              child: Text('Bayar ${_formatPrice(widget.total)}'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodTile(int index, Map<String, dynamic> method) {
    final selected = _selectedMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primary : AppColors.divider, width: selected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryLight : AppColors.divider,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(method['icon'], color: selected ? AppColors.primary : AppColors.textSecondary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text(method['desc'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Radio(value: index, groupValue: _selectedMethod, onChanged: (v) => setState(() => _selectedMethod = v!), activeColor: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: isTotal ? 15 : 13, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? AppColors.textPrimary : AppColors.textSecondary)),
        Text(value, style: TextStyle(fontSize: isTotal ? 15 : 13, fontWeight: FontWeight.bold, color: isTotal ? AppColors.primary : AppColors.textPrimary)),
      ],
    );
  }
}