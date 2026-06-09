import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/menu/presentation/bloc/menu_bloc.dart';
import '../../features/restaurant/data/datasources/local_datasource.dart';
import '../../features/restaurant/data/datasources/remote_datasource.dart';
import '../../features/restaurant/data/repositories/restaurant_repo_impl.dart';
import '../../features/restaurant/domain/repositories/restaurant_repository.dart';
import '../../features/restaurant/domain/usecases/get_restaurants.dart';
import '../../features/restaurant/presentation/bloc/restaurant_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSource(),
  );

  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(sl()),
  );

  sl.registerFactory<RestaurantBloc>(() => RestaurantBloc(
    getRestaurants: sl(),
    repository: sl(),
  ));
  sl.registerFactory<MenuBloc>(() => MenuBloc(sl()));
  sl.registerFactory<CartBloc>(() => CartBloc());
  sl.registerFactory<AuthBloc>(() => AuthBloc());
}