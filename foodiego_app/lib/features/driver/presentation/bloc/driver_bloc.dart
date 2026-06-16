import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/driver_websocket_datasource.dart';
import '../../domain/usecases/get_tracking_stream.dart';

abstract class DriverEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartTrackingEvent extends DriverEvent {
  final String orderId;
  StartTrackingEvent(this.orderId);
  @override
  List<Object> get props => [orderId];
}

class StopTrackingEvent extends DriverEvent {}

abstract class DriverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}
class DriverConnecting extends DriverState {}

class DriverTracking extends DriverState {
  final TrackingUpdate update;
  DriverTracking(this.update);
  @override
  List<Object> get props => [update];
}

class DriverError extends DriverState {
  final String message;
  DriverError(this.message);
  @override
  List<Object> get props => [message];
}

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final GetTrackingStreamUseCase getTrackingStream;
  StreamSubscription<TrackingUpdate>? _subscription;

  DriverBloc(this.getTrackingStream) : super(DriverInitial()) {
    on<StartTrackingEvent>((event, emit) async {
      emit(DriverConnecting());
      await emit.forEach<TrackingUpdate>(
        getTrackingStream(event.orderId),
        onData: (update) => DriverTracking(update),
        onError: (error, stack) => DriverError(error.toString()),
      );
    });

    on<StopTrackingEvent>((event, emit) {
      _subscription?.cancel();
      emit(DriverInitial());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}