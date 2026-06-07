import 'package:hive_flutter/hive_flutter.dart';
import '../models/restaurant_model.dart';

class RestaurantLocalDataSource {
  static const _boxName = 'restaurants';

  Future<void> cacheRestaurants(List<RestaurantModel> restaurants) async {
    final box = Hive.box(_boxName);
    final data = restaurants.map((r) => r.toJson()).toList();
    await box.put('data', data);
  }

  List<RestaurantModel> getCachedRestaurants() {
    final box = Hive.box(_boxName);
    final data = box.get('data', defaultValue: []);
    if (data == null || (data as List).isEmpty) return [];
    return data
        .map((json) => RestaurantModel.fromJson(
            Map<String, dynamic>.from(json)))
        .toList();
  }
}