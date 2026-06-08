import '../../domain/entities/driver.dart';

class DriverModel extends DriverEntity {
  const DriverModel({
    required super.id,
    required super.name,
    required super.vehicle,
    required super.plateNumber,
    required super.rating,
    required super.status,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      vehicle: json['vehicle'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vehicle': vehicle,
      'plateNumber': plateNumber,
      'rating': rating,
      'status': status,
    };
  }
}