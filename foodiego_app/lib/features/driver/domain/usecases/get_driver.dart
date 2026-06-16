import '../entities/driver.dart';
import '../repositories/driver_repository.dart';

class GetDriverUseCase {
  final DriverRepository repository;
  GetDriverUseCase(this.repository);

  Future<DriverEntity> call(String orderId) async {
    return await repository.getDriver(orderId);
  }
}