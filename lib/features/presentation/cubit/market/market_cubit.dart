import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';
import 'package:price_tracker/features/domain/entities/response/active_symbols_response.dart';
import 'package:price_tracker/features/domain/entities/response/asset_response.dart';
import 'package:price_tracker/features/domain/entities/response/market_response.dart';
import 'package:logger/logger.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit(this.socketClient)
      : super(MarketState(
          marketOptions: <MarketResponse>[],
          assetOptions: <AssetResponse>[],
          selectedMarket: '',
        ));

  final SocketClient socketClient;

  void connect() {
    socketClient.connect(Constant.wssUrl);
    socketClient.listen((res) {
      final results = jsonDecode(res);

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
      List<AssetResponse> assetOptions = activeSymbols
          .map((e) => AssetResponse(
              displayName: e.displayName, symbol: e.symbol, market: e.market))
          .toList();

      // Response to UI
      emit(MarketState(
          marketOptions: marketsFiltered,
          assetOptions: assetOptions,
          selectedMarket: marketsFiltered[0].market));
    });
  }

  void getActiveSymbols() {
    socketClient.send(
      jsonEncode(
        ActiveSymbolsRequest(
          activeSymbols: 'brief',
          productType: 'basic',
        ),
      ),
    );
  }

  void onTapChanged(String selectedMarket, List<MarketResponse> markets,
      List<AssetResponse> assets) {
    emit(MarketState(
      marketOptions: markets,
      assetOptions: assets,
      selectedMarket: selectedMarket,
    ));
  }

  void disconnect() {
    socketClient.disconnect();
  }
}
