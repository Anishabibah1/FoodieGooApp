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

  Stream<TrackingUpdate> get trackingStream {
    _controller ??= StreamController<TrackingUpdate>.broadcast();
    return _controller!.stream;
  }

  void connect(String orderId) {
    _controller = StreamController<TrackingUpdate>.broadcast();
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:8080/ws/tracking/$orderId'),
      );
      _channel!.stream.listen(
        (data) {
          final json = jsonDecode(data);
          _controller?.add(TrackingUpdate.fromJson(json));
        },
        onError: (error) => _controller?.addError(error),
        onDone: () => _controller?.close(),
      );
    } catch (e) {
      _controller?.addError(e);
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _controller?.close();
  }
}