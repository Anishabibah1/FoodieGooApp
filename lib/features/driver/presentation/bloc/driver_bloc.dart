import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/driver.dart';
import '../../domain/repositories/driver_repository.dart';

// EVENTS
abstract class DriverEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDriverEvent extends DriverEvent {
  final String orderId;
  LoadDriverEvent(this.orderId);
  @override
  List<Object> get props => [orderId];
}

class UpdateDeliveryStatusEvent extends DriverEvent {
  final String status;
  UpdateDeliveryStatusEvent(this.status);
  @override
  List<Object> get props => [status];
}

// STATES
abstract class DriverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}
class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final DriverEntity driver;
  final String status;
  DriverLoaded({required this.driver, required this.status});
  @override
  List<Object> get props => [driver, status];
}

class DriverError extends DriverState {
  final String message;
  DriverError(this.message);
  @override
  List<Object> get props => [message];
}

// BLOC
class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final DriverRepository repository;

  DriverBloc(this.repository) : super(DriverInitial()) {
    on<LoadDriverEvent>((event, emit) async {
      emit(DriverLoading());
      try {
        final driver = await repository.getDriver(event.orderId);
        final status = await repository.getDeliveryStatus(event.orderId);
        emit(DriverLoaded(driver: driver, status: status));
      } catch (e) {
        emit(DriverError(e.toString()));
      }
    });

    on<UpdateDeliveryStatusEvent>((event, emit) {
      if (state is DriverLoaded) {
        final current = state as DriverLoaded;
        emit(DriverLoaded(driver: current.driver, status: event.status));
      }
    });
  }
}