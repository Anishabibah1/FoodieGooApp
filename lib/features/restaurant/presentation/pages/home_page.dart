import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../bloc/restaurant_bloc.dart';
import '../../../menu/presentation/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RestaurantBloc>()..add(LoadRestaurantsEvent()),
      child: Scaffold(
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
                _buildRestaurantListFromAPI(),
                const SizedBox(height: 16),
              ],
            ),
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
                right: 8, top: 8,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
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
            const Positioned(
              right: 16, bottom: 0,
              child: Text('🍔', style: TextStyle(fontSize: 70)),
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
                    width: 56, height: 56,
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

  Widget _buildRestaurantListFromAPI() {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
          );
        } else if (state is RestaurantLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: state.restaurants.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final r = state.restaurants[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        name: r.name,
                        category: r.category,
                        rating: '4.5',
                        time: '25 menit',
                        emoji: '🍽️',
                        imageUrl: r.imageUrl,
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
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                          child: Image.network(
                            r.imageUrl,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 100,
                              color: AppColors.primaryLight,
                              child: const Center(child: Text('🍽️', style: TextStyle(fontSize: 40))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text(r.category, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              Row(
                                children: const [
                                  Icon(Icons.star, size: 13, color: Colors.amber),
                                  SizedBox(width: 2),
                                  Text('4.5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                                  SizedBox(width: 8),
                                  Icon(Icons.access_time, size: 13, color: AppColors.textSecondary),
                                  SizedBox(width: 2),
                                  Text('25 menit', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
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
        } else if (state is RestaurantError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.wifi_off, size: 40, color: AppColors.textHint),
                  SizedBox(height: 8),
                  Text('Tidak ada koneksi', style: TextStyle(color: AppColors.textSecondary)),
                  Text('Menampilkan data cache', style: TextStyle(fontSize: 12, color: AppColors.textHint)),
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 200);
      },
    );
  }
}