class MarketResponse {
  final String market;
  final String marketDisplayName;

  MarketResponse({
    required this.market,
    required this.marketDisplayName,
  });

  factory MarketResponse.fromJson(Map<String, dynamic> json) {
    return MarketResponse(
      market: json['market'],
      marketDisplayName: json['market_display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'market_display_name': marketDisplayName,
    };
  }
}
