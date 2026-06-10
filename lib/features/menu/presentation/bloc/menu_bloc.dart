import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

// ENTITY
class MenuItem {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final int price;

  const MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    final prices = [15000, 18000, 22000, 25000, 28000, 30000, 35000, 40000];
    final index = (json['id'] ?? json['idMeal'] ?? '0').hashCode.abs() % prices.length;
    return MenuItem(
      id: json['id'] ?? json['idMeal'] ?? '',
      name: json['name'] ?? json['strMeal'] ?? '',
      category: json['category'] ?? json['strCategory'] ?? '',
      imageUrl: json['image_url'] ?? json['strMealThumb'] ?? '',
      price: json['price'] ?? prices[index],
    );
  }
}

// EVENTS
abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMenuEvent extends MenuEvent {
  final String keyword;
  LoadMenuEvent(this.keyword);
  @override
  List<Object> get props => [keyword];
}

// STATES
abstract class MenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> items;
  MenuLoaded(this.items);
  @override
  List<Object> get props => [items];
}

class MenuError extends MenuState {
  final String message;
  MenuError(this.message);
  @override
  List<Object> get props => [message];
}

// BLOC
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final Dio dio;

  MenuBloc(this.dio) : super(MenuInitial()) {
    on<LoadMenuEvent>((event, emit) async {
      emit(MenuLoading());
      try {
        final response = await dio.get(
          'http://localhost:8080/api/restaurants/${event.keyword}/menu',
        );
        final List meals = response.data['data'] ?? [];
        final items = meals.map((json) => MenuItem.fromJson(json)).toList();
        emit(MenuLoaded(items));
      } catch (e) {
        // Fallback ke TheMealDB kalau backend tidak jalan
        try {
          final keyword = event.keyword.split(' ').first;
          final response = await dio.get(
            'https://www.themealdb.com/api/json/v1/1/search.php?s=$keyword',
          );
          final List meals = response.data['meals'] ?? [];
          final items = meals.map((json) => MenuItem.fromJson(json)).toList();
          emit(MenuLoaded(items));
        } catch (e2) {
          emit(MenuError('Gagal memuat menu'));
        }
      }
    });
  }
}