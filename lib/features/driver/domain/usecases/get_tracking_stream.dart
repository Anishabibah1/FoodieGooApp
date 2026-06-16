import 'dart:async';
import '../../data/datasources/driver_websocket_datasource.dart';

class GetTrackingStreamUseCase {
  final DriverWebSocketDataSource dataSource;
  GetTrackingStreamUseCase(this.dataSource);

  Stream<TrackingUpdate> call(String orderId) {
    dataSource.connect(orderId);
    return dataSource.trackingStream;
  }
}