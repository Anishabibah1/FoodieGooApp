import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';

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
      final remote = await remoteDataSource.getRestaurants();
      await localDataSource.cacheRestaurants(remote);
      return remote;
    } catch (e) {
      final cached = localDataSource.getCachedRestaurants();
      if (cached.isNotEmpty) return cached;
      throw Exception('Tidak ada koneksi dan tidak ada cache');
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      final results = await remoteDataSource.searchRestaurants(query);
      return results;
    } catch (e) {
      throw Exception('Gagal mencari: $e');
    }
  }
}