import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/usecases/get_restaurants.dart';

// EVENTS
abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRestaurantsEvent extends RestaurantEvent {}

// STATES
abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}
class RestaurantLoading extends RestaurantState {}
class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  RestaurantLoaded(this.restaurants);
  @override
  List<Object> get props => [restaurants];
}
class RestaurantError extends RestaurantState {
  final String message;
  RestaurantError(this.message);
  @override
  List<Object> get props => [message];
}

// BLOC
class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurantsUseCase getRestaurants;

  RestaurantBloc(this.getRestaurants) : super(RestaurantInitial()) {
    on<LoadRestaurantsEvent>((event, emit) async {
      emit(RestaurantLoading());
      try {
        final restaurants = await getRestaurants();
        emit(RestaurantLoaded(restaurants));
      } catch (e) {
        emit(RestaurantError(e.toString()));
      }
    });
  }
}