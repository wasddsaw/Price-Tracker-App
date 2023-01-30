part of 'price_tracker_cubit.dart';

class PriceTrackerState {
  final List<MarketResponse> markets;
  final List<MarketResponse> marketsFiltered;
  final List<AssetResponse> assets;
  final List<AssetResponse> assetsFiltered;
  final String selectedMarket;
  final String selectedAsset;

  PriceTrackerState({
    required this.markets,
    required this.marketsFiltered,
    required this.assets,
    required this.assetsFiltered,
    required this.selectedMarket,
    required this.selectedAsset,
  });
}
