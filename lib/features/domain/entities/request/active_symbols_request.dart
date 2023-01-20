class ActiveSymbolsRequest {
  final String activeSymbols;
  final String productType;

  ActiveSymbolsRequest({
    required this.activeSymbols,
    required this.productType,
  });

  factory ActiveSymbolsRequest.fromJson(Map<String, dynamic> json) {
    return ActiveSymbolsRequest(
      activeSymbols: json['activeSymbols'],
      productType: json['productType'],
    );
  }
}
