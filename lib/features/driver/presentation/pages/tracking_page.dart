import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int _currentStep = 0;

  final List<Map<String, dynamic>> _steps = [
    {'title': 'Pesanan Diterima', 'desc': 'Restoran sedang memproses pesananmu', 'icon': Icons.receipt_outlined},
    {'title': 'Sedang Dimasak', 'desc': 'Makananmu sedang disiapkan', 'icon': Icons.restaurant_outlined},
    {'title': 'Driver Menjemput', 'desc': 'Driver menuju ke restoran', 'icon': Icons.delivery_dining_outlined},
    {'title': 'Dalam Perjalanan', 'desc': 'Driver sedang menuju lokasimu', 'icon': Icons.directions_bike_outlined},
    {'title': 'Pesanan Tiba', 'desc': 'Pesananmu sudah sampai!', 'icon': Icons.check_circle_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Lacak Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Info driver
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52, height: 52,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Text('🧑', style: TextStyle(fontSize: 28))),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Budi Santoso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Driver FoodieGoo', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            SizedBox(width: 4),
                            Text('4.9', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                            SizedBox(width: 8),
                            Text('Honda Beat • B 1234 XYZ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.phone_outlined, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Status tracking
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Status Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 16),
                  ...(_steps.asMap().entries.map((e) => _buildStep(e.key, e.value)).toList()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Estimasi waktu
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.access_time, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('Estimasi tiba: ', style: TextStyle(color: AppColors.primaryDark)),
                  Text('15-20 menit', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Simulasi tombol next step
            if (_currentStep < _steps.length - 1)
              ElevatedButton(
                onPressed: () => setState(() => _currentStep++),
                child: const Text('Simulasi Status Berikutnya'),
              ),
            if (_currentStep == _steps.length - 1)
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('Selesai — Kembali ke Beranda'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int index, Map<String, dynamic> step) {
    final isDone = index < _currentStep;
    final isActive = index == _currentStep;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: isDone || isActive ? AppColors.primary : AppColors.divider,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check : step['icon'],
                  color: isDone || isActive ? Colors.white : AppColors.textHint,
                  size: 18,
                ),
              ),
              if (index < _steps.length - 1)
                Container(
                  width: 2, height: 30,
                  color: isDone ? AppColors.primary : AppColors.divider,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                      color: isActive ? AppColors.primary : (isDone ? AppColors.textSecondary : AppColors.textPrimary),
                    ),
                  ),
                  if (isActive)
                    Text(step['desc'], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}