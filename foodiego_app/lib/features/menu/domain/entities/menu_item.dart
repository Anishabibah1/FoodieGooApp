class MenuItemEntity {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final int price;
  final String description;

  const MenuItemEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    this.description = '',
  });
}