import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/restaurant/data/datasources/local_datasource.dart';
import '../../features/restaurant/data/datasources/remote_datasource.dart';
import '../../features/restaurant/data/repositories/restaurant_repo_impl.dart';
import '../../features/restaurant/domain/repositories/restaurant_repository.dart';
import '../../features/restaurant/domain/usecases/get_restaurants.dart';
import '../../features/restaurant/presentation/bloc/restaurant_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // DataSources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSource(),
  );

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<GetRestaurantsUseCase>(
    () => GetRestaurantsUseCase(sl()),
  );

  // BLoC — pakai registerFactory bukan registerLazySingleton
  sl.registerFactory<RestaurantBloc>(
    () => RestaurantBloc(sl()),
  );
}