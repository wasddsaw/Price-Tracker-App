import 'package:web_socket_channel/io.dart';

class SocketClient {
  late IOWebSocketChannel _channel;

  //connect to websocket
  void connect(String url) {
    _channel = IOWebSocketChannel.connect(url);
  }

  //disconnect
  void disconnect() {
    _channel.sink.close();
  }

  //listen to incoming message
  void listen(Function callback) {
    _channel.stream.listen((message) {
      callback(message);
    });
  }

  //send message
  void send(dynamic message) {
    _channel.sink.add(message);
  }
}
