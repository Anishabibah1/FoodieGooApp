import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class TrackingUpdate {
  final String orderId;
  final String status;
  final String message;
  final int step;

  const TrackingUpdate({
    required this.orderId,
    required this.status,
    required this.message,
    required this.step,
  });

  factory TrackingUpdate.fromJson(Map<String, dynamic> json) {
    return TrackingUpdate(
      orderId: json['order_id'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      step: json['step'] ?? 0,
    );
  }
}

class DriverWebSocketDataSource {
  WebSocketChannel? _channel;
  StreamController<TrackingUpdate>? _controller;
  Timer? _simulationTimer;
  int _simulationStep = 0;

  Stream<TrackingUpdate> get trackingStream {
    _controller ??= StreamController<TrackingUpdate>.broadcast();
    return _controller!.stream;
  }

  void connect(String orderId) {
    _controller = StreamController<TrackingUpdate>.broadcast();
    _simulationStep = 0;

    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8080/ws/tracking/$orderId'),
      );

      _channel!.stream.listen(
        (data) {
          try {
            final json = jsonDecode(data);
            _controller?.add(TrackingUpdate.fromJson(json));
          } catch (e) {
            _startSimulation(orderId);
          }
        },
        onError: (error) {
          _startSimulation(orderId);
        },
        onDone: () {
          _controller?.close();
        },
      );
    } catch (e) {
      _startSimulation(orderId);
    }
  }

  void _startSimulation(String orderId) {
    final steps = [
      TrackingUpdate(orderId: orderId, status: 'order_received', message: 'Pesanan diterima oleh restoran', step: 0),
      TrackingUpdate(orderId: orderId, status: 'preparing', message: 'Makananmu sedang disiapkan', step: 1),
      TrackingUpdate(orderId: orderId, status: 'driver_pickup', message: 'Driver menuju ke restoran', step: 2),
      TrackingUpdate(orderId: orderId, status: 'on_delivery', message: 'Driver sedang menuju lokasimu', step: 3),
      TrackingUpdate(orderId: orderId, status: 'arrived', message: 'Pesananmu sudah sampai!', step: 4),
    ];

    _simulationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_simulationStep < steps.length) {
        _controller?.add(steps[_simulationStep]);
        _simulationStep++;
      } else {
        timer.cancel();
      }
    });
  }

  void disconnect() {
    _simulationTimer?.cancel();
    _channel?.sink.close();
    _controller?.close();
  }
}