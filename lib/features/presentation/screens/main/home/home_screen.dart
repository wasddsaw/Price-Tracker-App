import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final socketClient = SocketClient();
  @override
  void initState() {
    super.initState();
    onConnection();
  }

  void onConnection() {
    debugPrint('onConnection');
    socketClient.connect(Constant.wssUrl);
    socketClient.listen((message) {
      debugPrint(log(message));
    });
  }

  void onSend() {
    debugPrint('onSend');
    socketClient.send(
      ActiveSymbolsRequest(
        activeSymbols: 'brief',
        productType: 'basic',
      ),
    );
  }

  String log(jsonObject) {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Tracker'),
        centerTitle: true,
      ),
      body: ElevatedButton.icon(
        onPressed: () {
          onSend();
        },
        icon: const Icon(
          Icons.download,
          size: 24.0,
        ),
        label: const Text('Download'), // <-- Text
      ),
    );
  }
}
