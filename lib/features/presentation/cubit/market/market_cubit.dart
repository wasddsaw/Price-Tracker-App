import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';
import 'package:price_tracker/features/domain/entities/response/market_response.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final SocketClient socketClient;

  MarketCubit(this.socketClient)
      : super(
          MarketState(
            markets: const [],
          ),
        );

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
