import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _query = '';
  String _selectedCategory = 'Semua';
  String _selectedSort = 'Rating';

  final List<String> _recentSearches = [
    'Nasi Goreng',
    'Ayam Geprek',
    'Sushi',
    'Kopi Susu',
  ];

  final List<String> _sortOptions = [
    'Rating',
    'Terdekat',
    'Termurah',
    'Terlaris',
  ];

  List<RestaurantModel> get _results {
    List<RestaurantModel> list = DummyData.getByCategory(_selectedCategory);

    if (_query.isNotEmpty) {
      list = list.where((r) {
        return r.name.toLowerCase().contains(_query.toLowerCase()) ||
            r.category.toLowerCase().contains(_query.toLowerCase());
      }).toList();
    }

    switch (_selectedSort) {
      case 'Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Terdekat':
        list.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'Termurah':
        list.sort((a, b) => a.deliveryFee.compareTo(b.deliveryFee));
        break;
      case 'Terlaris':
        list.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }

    return list;
  }

  bool get _isSearching => _query.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    setState(() => _query = value);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
    _focusNode.requestFocus();
  }

  void _selectRecent(String text) {
    _searchController.text = text;
    setState(() => _query = text);
    _focusNode.unfocus();
  }

  void _removeRecent(int index) {
    setState(() => _recentSearches.removeAt(index));
  }

  void _addToRecent(String text) {
    if (text.isEmpty) return;
    setState(() {
      _recentSearches.remove(text);
      _recentSearches.insert(0, text);
      if (_recentSearches.length > 6) _recentSearches.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FoodieColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildFilterBar(),
            Expanded(
              child: _isSearching ? _buildResults() : _buildDefaultView(),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SEARCH BAR
  // ─────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      color: FoodieColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: FoodieColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: FoodieColors.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          // Search field
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: _onSearch,
              onSubmitted: (v) {
                _addToRecent(v);
                _focusNode.unfocus();
              },
              style: const TextStyle(
                fontSize: 14,
                color: FoodieColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Cari makanan atau restoran...',
                hintStyle: const TextStyle(
                  color: FoodieColors.textHint,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: FoodieColors.background,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: FoodieColors.primary,
                  size: 20,
                ),
                suffixIcon: _query.isNotEmpty
                    ? GestureDetector(
                        onTap: _clearSearch,
                        child: const Icon(Icons.cancel,
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
                  borderSide: const BorderSide(
                      color: FoodieColors.primary, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // FILTER BAR (Category + Sort)
  // ─────────────────────────────────────────────
  Widget _buildFilterBar() {
    return Container(
      color: FoodieColors.surface,
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          const Divider(height: 1, color: FoodieColors.divider),
          const SizedBox(height: 10),
          // Category chips
          SizedBox(
            height: 34,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: DummyData.categories.length,
              itemBuilder: (context, index) {
                final cat = DummyData.categories[index];
                final isSelected = _selectedCategory == cat.name;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedCategory = cat.name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? FoodieColors.primary
                          : FoodieColors.background,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? FoodieColors.primary
                            : FoodieColors.divider,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${cat.emoji} ${cat.name}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : FoodieColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Sort chips
          SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _sortOptions.length,
              itemBuilder: (context, index) {
                final sort = _sortOptions[index];
                final isSelected = _selectedSort == sort;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSort = sort),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? FoodieColors.primarySurface
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? FoodieColors.primary
                            : FoodieColors.divider,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.check,
                                size: 12, color: FoodieColors.primary),
                          ),
                        Text(
                          sort,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? FoodieColors.primary
                                : FoodieColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // DEFAULT VIEW (Recent + Popular)
  // ─────────────────────────────────────────────
  Widget _buildDefaultView() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Recent searches
        if (_recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pencarian Terakhir',
                  style: FoodieTextStyles.titleSmall),
              GestureDetector(
                onTap: () => setState(() => _recentSearches.clear()),
                child: const Text(
                  'Hapus semua',
                  style: TextStyle(
                    fontSize: 12,
                    color: FoodieColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._recentSearches.asMap().entries.map((entry) {
            return _buildRecentItem(entry.value, entry.key);
          }),
          const SizedBox(height: 24),
        ],

        // Popular categories
        const Text('Kategori Populer', style: FoodieTextStyles.titleSmall),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.4,
          children: DummyData.categories
              .where((c) => c.name != 'Semua')
              .map((cat) => _buildCategoryCard(cat))
              .toList(),
        ),

        const SizedBox(height: 24),

        // Popular restaurants
        const Text('Restoran Terpopuler', style: FoodieTextStyles.titleSmall),
        const SizedBox(height: 12),
        ...DummyData.restaurants
            .where((r) => r.reviewCount > 1000)
            .map((r) => _buildCompactCard(r)),
      ],
    );
  }

  Widget _buildRecentItem(String text, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: FoodieColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.history_rounded,
              size: 18, color: FoodieColors.textHint),
        ),
        title: Text(text, style: FoodieTextStyles.bodyLarge),
        trailing: GestureDetector(
          onTap: () => _removeRecent(index),
          child: const Icon(Icons.close,
              size: 16, color: FoodieColors.textHint),
        ),
        onTap: () => _selectRecent(text),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryModel cat) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = cat.name;
          _query = cat.name;
          _searchController.text = cat.name;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: FoodieColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: FoodieColors.divider, width: 0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cat.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              cat.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: FoodieColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SEARCH RESULTS
  // ─────────────────────────────────────────────
  Widget _buildResults() {
    final results = _results;

    if (results.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Result count
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  style: FoodieTextStyles.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${results.length} restoran',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: FoodieColors.textPrimary,
                      ),
                    ),
                    const TextSpan(text: ' ditemukan untuk '),
                    TextSpan(
                      text: '"$_query"',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: FoodieColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: results.length,
            itemBuilder: (context, index) =>
                _buildResultCard(results[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(RestaurantModel r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: FoodieColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FoodieColors.divider, width: 0.8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          // Image
          Stack(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Image.network(
                  r.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: FoodieColors.background,
                    child: const Icon(Icons.restaurant,
                        color: FoodieColors.textHint, size: 32),
                  ),
                ),
              ),
              if (!r.isOpen)
                Container(
                  width: 110,
                  height: 110,
                  color: Colors.black45,
                  child: const Center(
                    child: Text(
                      'TUTUP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + favorite
                  Row(
                    children: [
                      Expanded(
                        child: Text(r.name,
                            style: FoodieTextStyles.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      if (r.isFavorite)
                        const Icon(Icons.favorite,
                            color: FoodieColors.error, size: 15),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: FoodieColors.primarySurface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      r.category,
                      style: const TextStyle(
                        fontSize: 10,
                        color: FoodieColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Rating + distance
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: FoodieColors.rating, size: 13),
                      const SizedBox(width: 2),
                      Text(
                        r.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: FoodieColors.textPrimary,
                        ),
                      ),
                      Text(
                        ' · ${r.distance} km · ${r.deliveryTime} min',
                        style: FoodieTextStyles.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Delivery fee
                  Row(
                    children: [
                      const Icon(Icons.delivery_dining_outlined,
                          size: 13, color: FoodieColors.textHint),
                      const SizedBox(width: 4),
                      Text(
                        r.deliveryFee == 0
                            ? 'Gratis Ongkir'
                            : DummyData.formatPrice(r.deliveryFee),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: r.deliveryFee == 0
                              ? FoodieColors.success
                              : FoodieColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCard(RestaurantModel r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FoodieColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: FoodieColors.divider, width: 0.8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 52,
              height: 52,
              child: Image.network(r.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                        color: FoodieColors.background,
                        child: const Icon(Icons.restaurant,
                            color: FoodieColors.textHint),
                      )),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.name,
                    style: FoodieTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('${r.category} · ${r.distance} km',
                    style: FoodieTextStyles.labelSmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star_rounded,
                      color: FoodieColors.rating, size: 13),
                  const SizedBox(width: 2),
                  Text(r.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: FoodieColors.textPrimary,
                      )),
                ],
              ),
              const SizedBox(height: 3),
              Text('${r.reviewCount} ulasan',
                  style: FoodieTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // EMPTY STATE
  // ─────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: FoodieColors.primarySurface,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.search_off_rounded,
                  size: 50, color: FoodieColors.primary),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tidak Ditemukan',
              style: FoodieTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Hasil untuk "$_query" tidak ada.\nCoba kata kunci lain.',
              style: FoodieTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _clearSearch,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: FoodieColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Reset Pencarian',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}