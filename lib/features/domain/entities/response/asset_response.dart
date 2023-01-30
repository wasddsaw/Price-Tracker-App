class AssetResponse {
  final String displayName;
  final String symbol;
  final String market;

  AssetResponse({
    required this.displayName,
    required this.symbol,
    required this.market,
  });

  factory AssetResponse.fromJson(Map<String, dynamic> json) {
    return AssetResponse(
      displayName: json['display_name'],
      market: json['market'],
      symbol: json['symbol'],
    );
  }
}
