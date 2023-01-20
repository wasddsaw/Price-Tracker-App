class MarketResponse {
  final int allowForwardStarting;
  final String displayName;
  final int displayOrder;
  final int exchangeIsOpen;
  final int isTradingSuspended;
  final String market;
  final String marketDisplayName;
  final double pip;
  final String subgroup;
  final String subgroupDisplayName;
  final String submarket;
  final String submarketDisplayName;
  final String symbol;
  final String symbolType;

  MarketResponse({
    required this.allowForwardStarting,
    required this.displayName,
    required this.displayOrder,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.subgroup,
    required this.subgroupDisplayName,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });

  factory MarketResponse.fromJson(Map<String, dynamic> json) {
    return MarketResponse(
      allowForwardStarting: json['allow_forward_starting'],
      displayName: json['display_name'],
      displayOrder: json['display_order'],
      exchangeIsOpen: json['exchange_is_open'],
      isTradingSuspended: json['is_trading_suspended'],
      market: json['market'],
      marketDisplayName: json['market_display_name'],
      pip: json['pip'],
      subgroup: json['subgroup'],
      subgroupDisplayName: json['subgroup_display_name'],
      submarket: json['submarket'],
      submarketDisplayName: json['submarket_display_name'],
      symbol: json['symbol'],
      symbolType: json['symbol_type'],
    );
  }
}
