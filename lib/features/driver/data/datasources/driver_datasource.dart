import '../models/driver_model.dart';

class DriverDataSource {
  Future<DriverModel> getDriver(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const DriverModel(
      id: 'D-001',
      name: 'Budi Santoso',
      vehicle: 'Honda Beat',
      plateNumber: 'B 1234 XYZ',
      rating: 4.9,
      status: 'on_delivery',
    );
  }

  Future<String> getDeliveryStatus(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'on_delivery';
  }
}