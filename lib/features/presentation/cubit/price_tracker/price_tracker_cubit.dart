import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';
import 'package:price_tracker/features/domain/entities/response/active_symbols_response.dart';
import 'package:price_tracker/features/domain/entities/response/asset_response.dart';
import 'package:price_tracker/features/domain/entities/response/market_response.dart';

part 'price_tracker_state.dart';

class PriceTrackerCubit extends Cubit<PriceTrackerState> {
  PriceTrackerCubit(this.socketClient)
      : super(PriceTrackerState(
          markets: <MarketResponse>[],
          assets: <AssetResponse>[],
          selectedMarket: '',
          assetsFiltered: <AssetResponse>[],
          marketsFiltered: <MarketResponse>[],
          selectedAsset: '',
        ));

  final SocketClient socketClient;

  void connectToWebSocket() {
    Logger().d('connectToWebSocket');
    socketClient.connect(Constant.wssUrl);
    socketClient.listen((response) {
      final results = jsonDecode(response);
      Logger().d(results);

      // Active Symbols
      var json = results['active_symbols'] as List;
      List<ActiveSymbolsResponse> activeSymbols =
          json.map(((e) => ActiveSymbolsResponse.fromJson(e))).toList();

      // Markets
      List<MarketResponse> markets = activeSymbols
          .map((e) => MarketResponse(
                market: e.market,
                marketDisplayName: e.marketDisplayName,
              ))
          .toList();

      final seen = <String>{};

      List<MarketResponse> marketsFiltered = markets
          .where((market) => seen.add(market.marketDisplayName))
          .toList();

      Logger().d(jsonEncode(marketsFiltered));

      // Assets
      List<AssetResponse> assets = activeSymbols
          .map((e) => AssetResponse(
              displayName: e.displayName, symbol: e.symbol, market: e.market))
          .toList();

      List<AssetResponse> assetsFiltered = assets
          .where((asset) => asset.market
              .toLowerCase()
              .contains(marketsFiltered[1].market.toLowerCase()))
          .toList();

      // Response data to UI
      emit(PriceTrackerState(
        markets: markets,
        marketsFiltered: marketsFiltered,
        assets: assets,
        assetsFiltered: assetsFiltered,
        selectedMarket: marketsFiltered[1].market,
        selectedAsset: assetsFiltered[1].symbol,
      ));
    });
  }

  void getActiveSymbols() {
    Logger().d('getActiveSymbols');
    socketClient.send(
      jsonEncode(
        ActiveSymbolsRequest(
          activeSymbols: 'brief',
          productType: 'basic',
        ),
      ),
    );
  }

  void onTapChanged(
      String selectedMarket,
      String selectedAsset,
      List<MarketResponse> markets,
      List<AssetResponse> assets,
      List<MarketResponse> marketsFiltered,
      List<AssetResponse> assetsFiltered) {
    // Filter Assets
    List<AssetResponse> assetsFiltered = assets
        .where((asset) => asset.market
            .toLowerCase()
            .contains(marketsFiltered[0].market.toLowerCase()))
        .toList();

    // Response data to UI
    emit(PriceTrackerState(
      markets: markets,
      marketsFiltered: marketsFiltered,
      assets: assets,
      assetsFiltered: assetsFiltered,
      selectedMarket: selectedMarket,
      selectedAsset: selectedAsset,
    ));
  }

  void getAssets(
      String market, List<MarketResponse> markets, List<AssetResponse> assets) {
    // emit(PriceTrackerState(
    //   markets: markets,
    //   assets: assets,
    //   selectedMarket: market,
    // ));
  }

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

  // void connect() {
  //   socketClient.connect(Constant.wssUrl);
  //   socketClient.listen((res) {
  //     // debugPrint(const JsonEncoder.withIndent('  ').convert(res));
  //     // List<MarketResponse> activeSymbols = res['active_symbols'];
  //     // Logger().d(activeSymbols);
  //     // Logger().d(const JsonEncoder.withIndent('  ')
  //     //     .convert(jsonDecode(res)['active_symbols']));

  //     // final response = jsonDecode(res);
  //     // Logger().d(response['active_symbols']);

  //     var tagObjsJson = jsonDecode(res)['active_symbols'] as List;
  //     List<MarketResponse> activeSymbols =
  //         tagObjsJson.map(((e) => MarketResponse.fromJson(e))).toList();
  //     emit(MarketState(markets: activeSymbols));
  //   });
  // }
}
