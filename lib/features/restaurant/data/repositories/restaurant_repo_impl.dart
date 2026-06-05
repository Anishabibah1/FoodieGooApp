import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';
import '../models/restaurant_model.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;

  RestaurantRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      // Coba ambil dari API
      final remote = await remoteDataSource.getRestaurants();
      // Simpan ke cache
      await localDataSource.cacheRestaurants(remote);
      return remote;
    } catch (e) {
      // Kalau gagal/offline, ambil dari cache
      final cached = localDataSource.getCachedRestaurants();
      if (cached.isNotEmpty) return cached;
      throw Exception('Tidak ada koneksi dan tidak ada cache');
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      return await remoteDataSource.searchRestaurants(query);
    } catch (e) {
      throw Exception('Gagal mencari: $e');
    }
  }
}