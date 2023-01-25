import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';
import 'package:price_tracker/features/domain/entities/response/market_response.dart';
import 'package:logger/logger.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit(this.socketClient)
      : super(MarketState(markets: <MarketResponse>[]));

  final SocketClient socketClient;

  void connect() {
    socketClient.connect(Constant.wssUrl);
    socketClient.listen((res) {
      // debugPrint(const JsonEncoder.withIndent('  ').convert(res));
      // List<MarketResponse> activeSymbols = res['active_symbols'];
      // Logger().d(activeSymbols);
      // Logger().d(const JsonEncoder.withIndent('  ')
      //     .convert(jsonDecode(res)['active_symbols']));

      // final response = jsonDecode(res);
      // Logger().d(response['active_symbols']);

      var tagObjsJson = jsonDecode(res)['active_symbols'] as List;
      List<MarketResponse> activeSymbols =
          tagObjsJson.map(((e) => MarketResponse.fromJson(e))).toList();
      emit(MarketState(markets: activeSymbols));
    });
  }

  void getMarkets() {
    socketClient.send(
      jsonEncode(
        ActiveSymbolsRequest(
          activeSymbols: 'brief',
          productType: 'basic',
        ),
      ),
    );
  }

  void disconnect() {
    socketClient.disconnect();
  }

  // void connect() {
  //   debugPrint('connect to webscoket...');
  //   socketClient?.connect(Constant.wssUrl);
  //   socketClient?.listen(
  //     (res) {
  //       print(res);
  //       // debugPrint(jsonEncode(res));
  //     },
  //   );
  // }

  // void send() {
  //   debugPrint('send to webscoket...');
  //   socketClient?.send(
  //     jsonEncode(
  //       ActiveSymbolsRequest(
  //         activeSymbols: 'brief',
  //         productType: 'basic',
  //       ),
  //     ),
  //   );
  // }

  // void getMarkets() {
  //   debugPrint('getMarkets');
  //   socketClient?.connect(Constant.wssUrl);
  //   socketClient?.send(
  //     jsonEncode(
  //       ActiveSymbolsRequest(
  //         activeSymbols: 'brief',
  //         productType: 'basic',
  //       ),
  //     ),
  //   );
  //   socketClient?.listen(
  //     (res) {
  //       print(res);
  //       emit(
  //         MarketState(
  //           markets: res['active_symbols'],
  //         ),
  //       );
  //     },
  //   );
  // }
}
