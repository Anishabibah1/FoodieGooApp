class Restaurant {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String area;
  final double rating;
  final String time;

  const Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.area,
    this.rating = 4.5,
    this.time = '25 menit',
  });
}