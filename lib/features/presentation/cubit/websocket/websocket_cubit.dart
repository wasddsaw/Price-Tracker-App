import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum WebSocketStatus {
  connecting,
  connected,
  disconnected,
}

class WebSocketCubit extends Cubit<WebSocketStatus> {
  WebSocketCubit() : super(WebSocketStatus.disconnected);

  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(Constant.wssUrl));

  void connect() {
    emit(WebSocketStatus.connecting);
    channel.stream.listen((data) {
      debugPrint(jsonEncode(data));
      emit(WebSocketStatus.connected);
    }, onError: (error) {
      emit(WebSocketStatus.disconnected);
    }, onDone: () {
      emit(WebSocketStatus.disconnected);
    });
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void disconnect() {
    channel.sink.close();
    emit(WebSocketStatus.disconnected);
  }
}
