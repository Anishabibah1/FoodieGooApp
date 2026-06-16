import '../../domain/entities/driver.dart';
import '../../domain/repositories/driver_repository.dart';
import '../datasources/driver_websocket_datasource.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DriverWebSocketDataSource dataSource;
  DriverRepositoryImpl(this.dataSource);

  @override
  Future<DriverEntity> getDriver(String orderId) async {
    return const DriverEntity(
      id: 'D-001',
      name: 'Budi Santoso',
      vehicle: 'Honda Beat',
      plateNumber: 'B 1234 XYZ',
      rating: 4.9,
      status: 'on_delivery',
    );
  }

  @override
  Future<String> getDeliveryStatus(String orderId) async {
    return 'on_delivery';
  }
}