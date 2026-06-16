import 'package:dio/dio.dart';
import '../models/restaurant_model.dart';

class RestaurantRemoteDataSource {
  final Dio dio;
  RestaurantRemoteDataSource(this.dio);

  Future<List<RestaurantModel>> getRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final response = await dio.get(
      'http://localhost:8080/api/restaurants',
    );
    final List data = response.data['data'] ?? [];
    return data.map((json) => RestaurantModel.fromJson(json)).toList();
  }

  Future<List<RestaurantModel>> searchRestaurants(String query) async {
    final response = await dio.get(
      'http://localhost:8080/api/restaurants/search?q=$query',
    );
    final List data = response.data['data'] ?? [];
    return data.map((json) => RestaurantModel.fromJson(json)).toList();
  }
}