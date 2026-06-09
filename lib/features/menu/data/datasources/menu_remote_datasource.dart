import 'package:dio/dio.dart';
import '../models/menu_model.dart';

class MenuRemoteDataSource {
  final Dio dio;
  MenuRemoteDataSource(this.dio);

  Future<List<MenuModel>> getMenuByKeyword(String keyword) async {
    final firstWord = keyword.split(' ').first;
    final response = await dio.get(
      'https://www.themealdb.com/api/json/v1/1/search.php?s=$firstWord',
    );
    final List meals = response.data['meals'] ?? [];
    return meals.map((json) => MenuModel.fromJson(json)).toList();
  }
}