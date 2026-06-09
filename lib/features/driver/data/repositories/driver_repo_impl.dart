import '../../domain/entities/driver.dart';
import '../../domain/repositories/driver_repository.dart';
import '../datasources/driver_datasource.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DriverDataSource dataSource;
  DriverRepositoryImpl(this.dataSource);

  @override
  Future<DriverEntity> getDriver(String orderId) async {
    try {
      return await dataSource.getDriver(orderId);
    } catch (e) {
      throw Exception('Gagal mengambil data driver: $e');
    }
  }

  @override
  Future<String> getDeliveryStatus(String orderId) async {
    try {
      return await dataSource.getDeliveryStatus(orderId);
    } catch (e) {
      throw Exception('Gagal mengambil status pengiriman: $e');
    }
  }
}