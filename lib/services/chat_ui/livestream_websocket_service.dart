import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:haptext_api/services/chat_ui/hapztext_api_service.dart';

class LivestreamWebsocketService {
  final HapzTextApiService _apiService;
  WebSocketChannel? _channel;
  
  StreamController<Map<String, dynamic>> _streamEventsController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get streamEvents => _streamEventsController.stream;

  Timer? _pingTimer;

  LivestreamWebsocketService(this._apiService);

  void connectToWebSocket(String streamId) {
    disconnectWebSocket(); // Close any existing connection

    final token = _apiService.token;
    if (token == null) {
      print('No token available for Livestream WebSocket connection');
      return;
    }

    final baseUrl = HapzTextApiService.baseUrl;
    final wsBaseUrl = baseUrl.replaceFirst('https://', 'wss://').replaceFirst('http://', 'ws://');
    
    // Connect to livestream consumer
    final wsUrl = '$wsBaseUrl/ws/livestream/$streamId/?token=$token';
    print('Connecting to Livestream WS: $wsUrl');
    
    try {
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      
      _channel!.stream.listen(
        (event) {
          try {
            final data = json.decode(event);
            _streamEventsController.add(data);
          } catch (e) {
            print('Error parsing Livestream WS message: $e');
          }
        },
        onError: (error) => print('Livestream WS error: $error'),
        onDone: () => print('Livestream WS disconnected'),
      );

      // Start ping heartbeat
      _pingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
        if (_channel != null) {
          _channel!.sink.add(json.encode({"type": "ping"}));
        }
      });
      
    } catch (e) {
      print('Error connecting to Livestream WebSocket: $e');
    }
  }

  void startStream(String title) {
    _sendMessage({
      "type": "start_stream",
      "title": title
    });
  }

  void endStream() {
    _sendMessage({
      "type": "end_stream"
    });
  }

  void sendComment(String text, {String commentType = 'text', String duration = ''}) {
    _sendMessage({
      "type": "send_comment",
      "text": text,
      "comment_type": commentType,
      "duration": duration
    });
  }

  void sendGift(String giftType) {
    _sendMessage({
      "type": "send_gift",
      "gift_type": giftType
    });
  }

  void sendReaction(String emoji) {
    _sendMessage({
      "type": "send_reaction",
      "emoji": emoji
    });
  }

  void _sendMessage(Map<String, dynamic> data) {
    if (_channel != null) {
      try {
        _channel!.sink.add(json.encode(data));
      } catch (e) {
        print('Error sending to Livestream WS: $e');
      }
    }
  }

  void disconnectWebSocket() {
    _pingTimer?.cancel();
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
  }

  void dispose() {
    disconnectWebSocket();
    _streamEventsController.close();
  }
}
