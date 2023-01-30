part of 'asset_cubit.dart';

class AssetState {
  final List<AssetResponse> assetOptions;
  final String selectedAsset;

  AssetState({
    required this.assetOptions,
    required this.selectedAsset,
  });
}
