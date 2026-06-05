import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../menu/presentation/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildBanner(),
              _buildCategories(),
              _buildSectionTitle('Restoran Terdekat'),
              _buildRestaurantList(),
              _buildSectionTitle('Promo Hari Ini'),
              _buildRestaurantList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Lokasi kamu 📍', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              Row(
                children: const [
                  Text('Jl. Sudirman No.1', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 26),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: AppColors.textHint),
            SizedBox(width: 10),
            Text('Cari restoran atau makanan...', style: TextStyle(color: AppColors.textHint, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Promo Spesial', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 8),
                  const Text('Diskon 50%\nPesanan Pertama!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3)),
                  const SizedBox(height: 8),
                  const Text('Pakai kode: FOODIEGOO', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 0,
              child: const Text('🍔', style: TextStyle(fontSize: 70)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'icon': '🍔', 'label': 'Burger'},
      {'icon': '🍕', 'label': 'Pizza'},
      {'icon': '🍜', 'label': 'Mie'},
      {'icon': '🍱', 'label': 'Bento'},
      {'icon': '🥗', 'label': 'Sehat'},
      {'icon': '🧋', 'label': 'Minuman'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kategori', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 85,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Center(child: Text(categories[i]['icon']!, style: const TextStyle(fontSize: 26))),
                  ),
                  const SizedBox(height: 6),
                  Text(categories[i]['label']!, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Text('Lihat semua', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRestaurantList() {
    final restaurants = [
      {'name': 'Warung Nasi Padang', 'category': 'Masakan Padang', 'rating': '4.8', 'time': '20 menit', 'emoji': '🍛'},
      {'name': 'Pizza Hut Express', 'category': 'Pizza & Pasta', 'rating': '4.6', 'time': '30 menit', 'emoji': '🍕'},
      {'name': 'Burger Kuy!', 'category': 'Burger & Snack', 'rating': '4.7', 'time': '25 menit', 'emoji': '🍔'},
    ];

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: restaurants.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final r = restaurants[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  name: r['name']!,
                  category: r['category']!,
                  rating: r['rating']!,
                  time: r['time']!,
                  emoji: r['emoji']!,
                ),
              ),
            ),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    ),
                    child: Center(
                      child: Text(r['emoji']!, style: const TextStyle(fontSize: 48)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(r['category']!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 13, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(r['rating']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                            const SizedBox(width: 8),
                            const Icon(Icons.access_time, size: 13, color: AppColors.textSecondary),
                            const SizedBox(width: 2),
                            Text(r['time']!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}