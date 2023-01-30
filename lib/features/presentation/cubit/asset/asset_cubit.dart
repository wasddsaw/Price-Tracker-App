import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:price_tracker/core/constant/constant.dart';
import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/response/active_symbols_response.dart';
import 'package:price_tracker/features/domain/entities/response/asset_response.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  AssetCubit() : super(AssetState(assetOptions: [], selectedAsset: ''));

  void getAssetData(List<AssetResponse> assets) {
    Logger().d('getAssetData');
    Logger().d(assets);
    emit(AssetState(assetOptions: assets, selectedAsset: ''));
  }

  // final SocketClient socketClient;

  // void connect() {
  //   socketClient.connect(Constant.wssUrl);
  //   socketClient.listen((res) {
  //     final results = jsonDecode(res);

  //     // Active Symbols
  //     var json = results['active_symbols'] as List;
  //     List<ActiveSymbolsResponse> activeSymbols =
  //         json.map(((e) => ActiveSymbolsResponse.fromJson(e))).toList();

  //     // Assets
  //     List<AssetResponse> assets = activeSymbols
  //         .map((e) => AssetResponse(
  //             displayName: e.displayName, symbol: e.symbol, market: e.market))
  //         .toList();

  //     // List<AssetResponse> assetsFiltered = assets
  //     //     .where((asset) => asset.market
  //     //         .toLowerCase()
  //     //         .contains(marketsFiltered[1].market.toLowerCase()))
  //     //     .toList();
  //   });
  // }
}
