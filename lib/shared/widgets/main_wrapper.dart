import 'package:flutter/material.dart';
import 'bottom_navbar.dart';
import '../../features/restaurant/presentation/pages/home_page.dart';
import '../../features/order/presentation/pages/order_history_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Scaffold(body: Center(child: Text('Halaman Cari'))),
    const Scaffold(body: Center(child: Text('Halaman Keranjang'))),
    const OrderHistoryPage(),
    const Scaffold(body: Center(child: Text('Halaman Profil'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}