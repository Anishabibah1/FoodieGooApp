import '../entities/driver.dart';

abstract class DriverRepository {
  Future<DriverEntity> getDriver(String orderId);
  Future<String> getDeliveryStatus(String orderId);
}