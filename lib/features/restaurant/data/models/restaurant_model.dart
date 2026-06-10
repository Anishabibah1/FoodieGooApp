import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.area,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? json['idMeal'] ?? '',
      name: json['name'] ?? json['strMeal'] ?? '',
      category: json['category'] ?? json['strCategory'] ?? '',
      imageUrl: json['image_url'] ?? json['strMealThumb'] ?? '',
      area: json['area'] ?? json['strArea'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image_url': imageUrl,
      'area': area,
    };
  }
}