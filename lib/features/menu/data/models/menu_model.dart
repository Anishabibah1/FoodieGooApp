import '../../domain/entities/menu_item.dart';

class MenuModel extends MenuItemEntity {
  const MenuModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.price,
    super.description,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    final prices = [15000, 18000, 22000, 25000, 28000, 30000, 35000, 40000];
    final index = (json['idMeal'] ?? '0').hashCode.abs() % prices.length;
    return MenuModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      imageUrl: json['strMealThumb'] ?? '',
      price: prices[index],
      description: json['strInstructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strCategory': category,
      'strMealThumb': imageUrl,
      'price': price,
      'strInstructions': description,
    };
  }
}