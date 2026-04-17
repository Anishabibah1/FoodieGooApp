import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 0;
  int _currentBannerIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController();

  List<RestaurantModel> get _filteredRestaurants {
    final category = DummyData.categories[_selectedCategoryIndex];
    final query = _searchController.text;
    List<RestaurantModel> list = DummyData.getByCategory(category.name);
    if (query.isNotEmpty) {
      list = list
          .where((r) =>
              r.name.toLowerCase().contains(query.toLowerCase()) ||
              r.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FoodieColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSliverHeader(),
            SliverToBoxAdapter(child: _buildCategorySection()),
            SliverToBoxAdapter(child: _buildBannerSection()),
            SliverToBoxAdapter(child: _buildSectionTitle('Restoran Populer 🔥')),
            _buildRestaurantList(),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ─────────────────────────────────────────────
  // SLIVER HEADER
  // ─────────────────────────────────────────────
  Widget _buildSliverHeader() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: FoodieColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: logo + notif
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FoodieGo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white70, size: 13),
                        SizedBox(width: 3),
                        Text(
                          'Denpasar, Bali',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.white70, size: 16),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 22),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: FoodieColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(fontSize: 14, color: FoodieColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Cari makanan atau restoran...',
                hintStyle: const TextStyle(
                    color: FoodieColors.textHint, fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search,
                    color: FoodieColors.textHint, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () => setState(() => _searchController.clear()),
                        child: const Icon(Icons.close,
                            color: FoodieColors.textHint, size: 18),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // KATEGORI
  // ─────────────────────────────────────────────
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Text('Kategori', style: FoodieTextStyles.titleMedium),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: DummyData.categories.length,
            itemBuilder: (context, index) {
              final cat = DummyData.categories[index];
              final isSelected = _selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategoryIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  width: 72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? FoodieColors.primary
                              : FoodieColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? FoodieColors.primary
                                : FoodieColors.divider,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat.emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? FoodieColors.primary
                              : FoodieColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // BANNER PROMO
  // ─────────────────────────────────────────────
  Widget _buildBannerSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Promo Hari Ini', style: FoodieTextStyles.titleMedium),
              Text(
                'Lihat semua',
                style: TextStyle(
                  fontSize: 13,
                  color: FoodieColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: DummyData.banners.length,
            onPageChanged: (i) => setState(() => _currentBannerIndex = i),
            itemBuilder: (context, index) {
              final banner = DummyData.banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: FoodieColors.primaryDark,
                ),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      banner.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: FoodieColors.primaryDark,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: FoodieColors.secondary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'PROMO',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner.subtitle,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Dot indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(DummyData.banners.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentBannerIndex == i ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentBannerIndex == i
                    ? FoodieColors.primary
                    : FoodieColors.divider,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // SECTION TITLE
  // ─────────────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: FoodieTextStyles.titleMedium),
          const Text(
            'Lihat semua',
            style: TextStyle(
              fontSize: 13,
              color: FoodieColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // RESTAURANT LIST
  // ─────────────────────────────────────────────
  Widget _buildRestaurantList() {
    final restaurants = _filteredRestaurants;

    if (restaurants.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Icon(Icons.search_off,
                  size: 48, color: FoodieColors.textHint),
              const SizedBox(height: 12),
              Text(
                'Tidak ada restoran ditemukan',
                style: FoodieTextStyles.bodyMedium
                    .copyWith(color: FoodieColors.textHint),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildRestaurantCard(restaurants[index]),
          childCount: restaurants.length,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // RESTAURANT CARD
  // ─────────────────────────────────────────────
  Widget _buildRestaurantCard(RestaurantModel restaurant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: FoodieColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: FoodieColors.divider, width: 0.8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.network(
                  restaurant.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 160,
                      color: FoodieColors.background,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: FoodieColors.primary, strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: FoodieColors.background,
                    child: const Center(
                      child: Icon(Icons.restaurant,
                          size: 40, color: FoodieColors.textHint),
                    ),
                  ),
                ),
              ),
              // Closed overlay
              if (!restaurant.isOpen)
                Container(
                  height: 160,
                  color: Colors.black45,
                  child: const Center(
                    child: Text(
                      'TUTUP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              // Favorite button
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    restaurant.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: restaurant.isFavorite
                        ? FoodieColors.error
                        : FoodieColors.textHint,
                    size: 18,
                  ),
                ),
              ),
              // Category badge
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    restaurant.category,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: FoodieColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Info section
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name, style: FoodieTextStyles.titleSmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Rating
                    const Icon(Icons.star_rounded,
                        color: FoodieColors.rating, size: 15),
                    const SizedBox(width: 3),
                    Text(
                      restaurant.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: FoodieColors.textPrimary,
                      ),
                    ),
                    Text(
                      ' (${restaurant.reviewCount})',
                      style: FoodieTextStyles.labelSmall,
                    ),
                    const SizedBox(width: 12),
                    // Distance
                    const Icon(Icons.place_outlined,
                        color: FoodieColors.textHint, size: 13),
                    const SizedBox(width: 2),
                    Text(
                      '${restaurant.distance} km',
                      style: FoodieTextStyles.labelSmall,
                    ),
                    const SizedBox(width: 12),
                    // Delivery time
                    const Icon(Icons.access_time_outlined,
                        color: FoodieColors.textHint, size: 13),
                    const SizedBox(width: 2),
                    Text(
                      '${restaurant.deliveryTime} min',
                      style: FoodieTextStyles.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Delivery fee + Best seller menu preview
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: restaurant.deliveryFee == 0
                            ? FoodieColors.success.withOpacity(0.1)
                            : FoodieColors.primarySurface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delivery_dining_outlined,
                            size: 13,
                            color: restaurant.deliveryFee == 0
                                ? FoodieColors.success
                                : FoodieColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.deliveryFee == 0
                                ? 'Gratis Ongkir'
                                : DummyData.formatPrice(restaurant.deliveryFee),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: restaurant.deliveryFee == 0
                                  ? FoodieColors.success
                                  : FoodieColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Best seller tag if any
                    if (restaurant.menus.any((m) => m.isBestSeller))
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: FoodieColors.secondarySurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                size: 13, color: FoodieColors.secondary),
                            SizedBox(width: 3),
                            Text(
                              'Best Seller',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: FoodieColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BOTTOM NAV BAR
  // ─────────────────────────────────────────────
  Widget _buildBottomNavBar() {
    const items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.search_rounded, 'label': 'Cari'},
      {'icon': Icons.receipt_long_outlined, 'label': 'Pesanan'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profil'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: FoodieColors.surface,
        border: Border(
          top: BorderSide(color: FoodieColors.divider, width: 0.8),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedNavIndex == index;
              final icon = items[index]['icon'] as IconData;
              final label = items[index]['label'] as String;
              return GestureDetector(
                onTap: () => setState(() => _selectedNavIndex = index),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? FoodieColors.primarySurface
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? FoodieColors.primary
                              : FoodieColors.textHint,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? FoodieColors.primary
                              : FoodieColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}