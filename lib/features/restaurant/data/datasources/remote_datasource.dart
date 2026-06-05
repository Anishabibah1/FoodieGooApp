import 'package:dio/dio.dart';
import '../models/restaurant_model.dart';

class RestaurantRemoteDataSource {
  final Dio dio;

  RestaurantRemoteDataSource(this.dio);

  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=chicken',
    );

    final List meals = response.data['meals'] ?? [];
    return meals.map((json) => RestaurantModel.fromJson(json)).toList();
  }

  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
    );

    final List meals = response.data['meals'] ?? [];
    return meals.map((json) => RestaurantModel.fromJson(json)).toList();
  }
}