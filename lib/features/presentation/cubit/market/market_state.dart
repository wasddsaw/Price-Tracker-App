part of 'market_cubit.dart';

class MarketState {
  final List<MarketResponse> marketOptions;
  final List<AssetResponse> assetOptions;
  final String selectedMarket;

  MarketState({
    required this.marketOptions,
    required this.assetOptions,
    required this.selectedMarket,
  });
}
