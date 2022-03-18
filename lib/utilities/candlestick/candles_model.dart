class CandlestickModel {
  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final DateTime closeTime;
  final double quoteAssetVolume;
  final int numberOfTrades;
  final double takerBuyBaseAssetVolume;
  final double takerBuyQuoteAssetVolume;
  final double ignore;

  // ignore: sort_constructors_first
  CandlestickModel(
      {required this.openTime,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume,
      required this.closeTime,
      required this.quoteAssetVolume,
      required this.numberOfTrades,
      required this.takerBuyBaseAssetVolume,
      required this.takerBuyQuoteAssetVolume,
      required this.ignore});

  // ignore: sort_constructors_first
  CandlestickModel.fromJson(List<dynamic> json)
      : openTime = DateTime.fromMillisecondsSinceEpoch(json[0]),
        open = double.parse(json[1]),
        high = double.parse(json[2]),
        low = double.parse(json[3]),
        close = double.parse(json[4]),
        volume = double.parse(json[5]),
        closeTime = DateTime.fromMillisecondsSinceEpoch(json[6]),
        quoteAssetVolume = double.parse(json[7]),
        numberOfTrades = int.parse(json[8]),
        takerBuyBaseAssetVolume = double.parse(json[9]),
        takerBuyQuoteAssetVolume = double.parse(json[10]),
        ignore = double.parse(json[11]);

  // ignore: sort_constructors_first
  CandlestickModel.fromMap(Map<String, dynamic> res)
      : openTime = res['openTime'],
        open = res['open'],
        high = res['high'],
        low = res['low'],
        close = res['close'],
        volume = res['volume'],
        closeTime = res['closeTime'],
        quoteAssetVolume = res['quoteAssetVolume'],
        numberOfTrades = res['numberOfTrades'],
        takerBuyBaseAssetVolume = res['takerBuyBaseAssetVolume'],
        takerBuyQuoteAssetVolume = res['takerBuyQuoteAssetVolume'],
        ignore = res['ignore'];

  Map<String, Object?> toMap() {
    return {
      'openTime': openTime,
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'volume': volume,
      'closeTime': closeTime,
      'quoteAssetVolume': quoteAssetVolume,
      'numberOfTrades': numberOfTrades,
      'takerBuyBaseAssetVolume': takerBuyQuoteAssetVolume,
      'takerBuyQuoteAssetVolume': takerBuyQuoteAssetVolume,
      'ignore': ignore
    };
  }
}
