import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String area;

  const Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.area,
  });

  @override
  List<Object> get props => [id, name, category, imageUrl, area];
}