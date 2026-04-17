class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final String deliveryTime; // estimasi menit
  final int deliveryFee;     // dalam rupiah
  final double distance;     // dalam km
  final bool isOpen;
  final bool isFavorite;
  final List<MenuModel> menus;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
    required this.isOpen,
    required this.isFavorite,
    required this.menus,
  });
}

class MenuModel {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String description;
  final bool isBestSeller;

  const MenuModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.isBestSeller,
  });
}

class CategoryModel {
  final String id;
  final String name;
  final String emoji;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

class BannerModel {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;

  const BannerModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

// ----- Dummy Data -------------------------------------------

class DummyData {
  DummyData._();

  // ---- Kategori --------------------------------------------
  static const List<CategoryModel> categories = [
    CategoryModel(id: 'cat_1', name: 'Semua',    emoji: '🍽️'),
    CategoryModel(id: 'cat_2', name: 'Nasi',     emoji: '🍚'),
    CategoryModel(id: 'cat_3', name: 'Ayam',     emoji: '🍗'),
    CategoryModel(id: 'cat_4', name: 'Mie',      emoji: '🍜'),
    CategoryModel(id: 'cat_5', name: 'Pizza',    emoji: '🍕'),
    CategoryModel(id: 'cat_6', name: 'Burger',   emoji: '🍔'),
    CategoryModel(id: 'cat_7', name: 'Sushi',    emoji: '🍣'),
    CategoryModel(id: 'cat_8', name: 'Minuman',  emoji: '🧋'),
    CategoryModel(id: 'cat_9', name: 'Dessert',  emoji: '🍰'),
  ];

  // ---- Banner Promo ----------------------------------------
  static const List<BannerModel> banners = [
    BannerModel(
      id: 'ban_1',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80',
      title: 'Gratis Ongkir!',
      subtitle: 'Min. order Rp 20.000',
    ),
    BannerModel(
      id: 'ban_2',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80',
      title: 'Diskon 50%',
      subtitle: 'Khusus order pertama',
    ),
    BannerModel(
      id: 'ban_3',
      imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80',
      title: 'Promo Makan Siang',
      subtitle: 'Setiap hari 11.00–13.00',
    ),
  ];

  // ---- Restoran --------------------------------------------
  static final List<RestaurantModel> restaurants = [
    RestaurantModel(
      id: 'res_1',
      name: 'Warung Nasi Padang Sederhana',
      imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
      category: 'Nasi',
      rating: 4.8,
      reviewCount: 1243,
      deliveryTime: '15–25',
      deliveryFee: 5000,
      distance: 0.8,
      isOpen: true,
      isFavorite: true,
      menus: [
        MenuModel(
          id: 'menu_1_1',
          name: 'Nasi Rendang',
          imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&q=80',
          price: 25000,
          description: 'Nasi putih dengan rendang daging sapi empuk khas Padang',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_1_2',
          name: 'Nasi Ayam Pop',
          imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80',
          price: 20000,
          description: 'Ayam pop goreng kering dengan bumbu kuning',
          isBestSeller: false,
        ),
        MenuModel(
          id: 'menu_1_3',
          name: 'Nasi Gulai Tunjang',
          imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&q=80',
          price: 22000,
          description: 'Gulai kikil sapi dengan kuah santan kental',
          isBestSeller: false,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_2',
      name: 'Geprek Bensu Sultan',
      imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=600&q=80',
      category: 'Ayam',
      rating: 4.6,
      reviewCount: 876,
      deliveryTime: '20–30',
      deliveryFee: 7000,
      distance: 1.2,
      isOpen: true,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_2_1',
          name: 'Geprek Original',
          imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=400&q=80',
          price: 18000,
          description: 'Ayam goreng crispy geprek sambal bawang level 1–5',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_2_2',
          name: 'Geprek Keju',
          imageUrl: 'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=400&q=80',
          price: 22000,
          description: 'Geprek original dengan lelehan keju mozarella',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_2_3',
          name: 'Paket Geprek + Es Teh',
          imageUrl: 'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=400&q=80',
          price: 25000,
          description: 'Satu geprek original + nasi + es teh manis',
          isBestSeller: false,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_3',
      name: 'Mie Gacoan Bali',
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
      category: 'Mie',
      rating: 4.7,
      reviewCount: 2105,
      deliveryTime: '25–35',
      deliveryFee: 6000,
      distance: 2.1,
      isOpen: true,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_3_1',
          name: 'Mie Setan Level 3',
          imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&q=80',
          price: 19000,
          description: 'Mie kuning pedas dengan topping ceker dan siomay',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_3_2',
          name: 'Mie Iblis',
          imageUrl: 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=400&q=80',
          price: 21000,
          description: 'Tingkat kepedasan tertinggi, ekstra sambal',
          isBestSeller: false,
        ),
        MenuModel(
          id: 'menu_3_3',
          name: 'Pangsit Goreng',
          imageUrl: 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=400&q=80',
          price: 10000,
          description: 'Pangsit goreng renyah isi daging ayam',
          isBestSeller: false,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_4',
      name: 'Pizza Hut Delivery',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&q=80',
      category: 'Pizza',
      rating: 4.4,
      reviewCount: 654,
      deliveryTime: '30–45',
      deliveryFee: 10000,
      distance: 3.5,
      isOpen: true,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_4_1',
          name: 'Super Supreme',
          imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&q=80',
          price: 89000,
          description: 'Pizza dengan topping sosis, paprika, jamur, dan keju',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_4_2',
          name: 'Cheesy 7',
          imageUrl: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400&q=80',
          price: 95000,
          description: 'Pizza dengan 7 jenis keju pilihan',
          isBestSeller: true,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_5',
      name: 'Burger Bangor',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80',
      category: 'Burger',
      rating: 4.5,
      reviewCount: 432,
      deliveryTime: '20–30',
      deliveryFee: 8000,
      distance: 1.7,
      isOpen: false,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_5_1',
          name: 'Burger Bangor ORI',
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
          price: 35000,
          description: 'Double beef patty, keju, selada, tomat, saus spesial',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_5_2',
          name: 'Chicken Crispy Burger',
          imageUrl: 'https://images.unsplash.com/photo-1561758033-d89a9ad46330?w=400&q=80',
          price: 30000,
          description: 'Ayam crispy dengan mayo dan acar',
          isBestSeller: false,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_6',
      name: 'Sushi Tei Express',
      imageUrl: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=600&q=80',
      category: 'Sushi',
      rating: 4.9,
      reviewCount: 3210,
      deliveryTime: '35–50',
      deliveryFee: 15000,
      distance: 4.0,
      isOpen: true,
      isFavorite: true,
      menus: [
        MenuModel(
          id: 'menu_6_1',
          name: 'Salmon Nigiri (2 pcs)',
          imageUrl: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400&q=80',
          price: 45000,
          description: 'Irisan salmon segar di atas nasi sushi',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_6_2',
          name: 'Dragon Roll',
          imageUrl: 'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80',
          price: 75000,
          description: 'Roll dengan ebi tempura, alpukat, dan saus unagi',
          isBestSeller: true,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_7',
      name: 'Kopi Kenangan',
      imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600&q=80',
      category: 'Minuman',
      rating: 4.6,
      reviewCount: 1876,
      deliveryTime: '10–20',
      deliveryFee: 5000,
      distance: 0.5,
      isOpen: true,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_7_1',
          name: 'Kopi Susu Kenangan',
          imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&q=80',
          price: 28000,
          description: 'Espresso dengan susu segar dan gula aren',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_7_2',
          name: 'Matcha Latte',
          imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=400&q=80',
          price: 32000,
          description: 'Matcha premium Jepang dengan susu oat',
          isBestSeller: false,
        ),
        MenuModel(
          id: 'menu_7_3',
          name: 'Brown Sugar Boba',
          imageUrl: 'https://images.unsplash.com/photo-1558857563-b371033873b8?w=400&q=80',
          price: 35000,
          description: 'Milk tea dengan boba gula aren dan tiger stripes',
          isBestSeller: true,
        ),
      ],
    ),

    RestaurantModel(
      id: 'res_8',
      name: 'Mixue Ice Cream',
      imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=600&q=80',
      category: 'Dessert',
      rating: 4.3,
      reviewCount: 987,
      deliveryTime: '15–25',
      deliveryFee: 5000,
      distance: 1.0,
      isOpen: true,
      isFavorite: false,
      menus: [
        MenuModel(
          id: 'menu_8_1',
          name: 'Soft Ice Cream Vanilla',
          imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400&q=80',
          price: 8000,
          description: 'Soft serve vanilla dengan cone renyah',
          isBestSeller: true,
        ),
        MenuModel(
          id: 'menu_8_2',
          name: 'Sundae Cokelat',
          imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=400&q=80',
          price: 15000,
          description: 'Es krim dengan topping saus cokelat dan kacang',
          isBestSeller: false,
        ),
      ],
    ),
  ];

  // ---- Helper: filter by category --------------------------
  static List<RestaurantModel> getByCategory(String categoryName) {
    if (categoryName == 'Semua') return restaurants;
    return restaurants
        .where((r) => r.category == categoryName)
        .toList();
  }

  // ---- Helper: search by name atau category ----------------
  static List<RestaurantModel> search(String query) {
    final q = query.toLowerCase();
    return restaurants.where((r) {
      return r.name.toLowerCase().contains(q) ||
             r.category.toLowerCase().contains(q);
    }).toList();
  }

  // ---- Helper: restoran yang sedang buka -------------------
  static List<RestaurantModel> getOpenRestaurants() {
    return restaurants.where((r) => r.isOpen).toList();
  }

  // ---- Helper: restoran favorit ----------------------------
  static List<RestaurantModel> getFavorites() {
    return restaurants.where((r) => r.isFavorite).toList();
  }

  // ---- Helper: format harga ke Rupiah ----------------------
  static String formatPrice(int price) {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}