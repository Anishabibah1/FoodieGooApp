import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../shared/theme/app_theme.dart';

class TrackingPage extends StatefulWidget {
  final String orderId;
  const TrackingPage({super.key, this.orderId = 'ORDER-001'});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  int _currentStep = 0;
  String _currentMessage = 'Menghubungkan ke server...';
  bool _isConnected = false;

  final List<Map<String, dynamic>> _steps = [
    {'title': 'Pesanan Diterima', 'desc': 'Restoran sedang memproses pesananmu', 'icon': Icons.receipt_outlined},
    {'title': 'Sedang Dimasak', 'desc': 'Makananmu sedang disiapkan', 'icon': Icons.restaurant_outlined},
    {'title': 'Driver Menjemput', 'desc': 'Driver menuju ke restoran', 'icon': Icons.delivery_dining_outlined},
    {'title': 'Dalam Perjalanan', 'desc': 'Driver sedang menuju lokasimu', 'icon': Icons.directions_bike_outlined},
    {'title': 'Pesanan Tiba', 'desc': 'Pesananmu sudah sampai!', 'icon': Icons.check_circle_outline},
  ];

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    try {
      // Koneksi ke backend WebSocket
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8080/ws/tracking/${widget.orderId}'),
      );

      setState(() => _isConnected = true);

      // Stream — listen data real-time dari backend
      _subscription = _channel!.stream.listen(
        (data) {
          final json = jsonDecode(data);
          setState(() {
            _currentStep = json['step'] ?? 0;
            _currentMessage = json['message'] ?? '';
          });
        },
        onError: (error) {
          setState(() {
            _isConnected = false;
            _currentMessage = 'Koneksi terputus, menggunakan simulasi...';
          });
          _startSimulation();
        },
        onDone: () {
          setState(() => _isConnected = false);
        },
      );
    } catch (e) {
      // Fallback ke simulasi kalau backend tidak jalan
      setState(() {
        _isConnected = false;
        _currentMessage = 'Backend tidak tersedia, menggunakan simulasi...';
      });
      _startSimulation();
    }
  }

  void _startSimulation() {
    // Simulasi update status kalau WebSocket tidak tersedia
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_currentStep < _steps.length - 1) {
        setState(() {
          _currentStep++;
          _currentMessage = _steps[_currentStep]['desc'];
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _channel?.sink.close();
    super.dispose();
  }

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
            _buildConnectionStatus(),
            const SizedBox(height: 16),
            _buildDriverInfo(),
            const SizedBox(height: 20),
            _buildTrackingStatus(),
            const SizedBox(height: 20),
            _buildEstimasi(),
            const SizedBox(height: 20),
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

  Widget _buildConnectionStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _isConnected ? const Color(0xFFD1FAE5) : const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isConnected ? Icons.wifi : Icons.wifi_off,
            size: 16,
            color: _isConnected ? AppColors.success : Colors.orange,
          ),
          const SizedBox(width: 6),
          Text(
            _isConnected ? 'Terhubung via WebSocket' : 'Mode Simulasi',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _isConnected ? AppColors.success : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person, size: 30, color: AppColors.primary),
            ),
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
    );
  }

  Widget _buildTrackingStatus() {
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
          const Text('Status Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          Text(_currentMessage, style: const TextStyle(fontSize: 13, color: AppColors.primary)),
          const SizedBox(height: 16),
          ..._steps.asMap().entries.map((e) => _buildStep(e.key, e.value)),
        ],
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
                width: 36,
                height: 36,
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
                Container(width: 2, height: 30, color: isDone ? AppColors.primary : AppColors.divider),
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
                      color: isActive ? AppColors.primary : isDone ? AppColors.textSecondary : AppColors.textPrimary,
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

  Widget _buildEstimasi() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Estimasi tiba: ', style: TextStyle(color: AppColors.primaryDark)),
          Text('15-20 menit', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}