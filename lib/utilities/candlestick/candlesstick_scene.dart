import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/flutter_k_chart.dart';

class CandlesStickScene extends StatefulWidget {
  static const String ruoteName = 'candlestick_page';
  // ignore: sort_constructors_first
  const CandlesStickScene({Key? key}) : super(key: key);

  @override
  _CandlesStickSceneState createState() => _CandlesStickSceneState();
}

class _CandlesStickSceneState extends State<CandlesStickScene> {
  //Candlestick
  // List<Candle> candles = [];
  //K_Chart
  List<KLineEntity>? datas;
  // bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = false;
  // List<DepthEntity>? _bids, _asks;
  bool isChangUI = false;
  SecondaryState dropdownValue = SecondaryState.MACD;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    // fetchCandles(symbol: "BTCUSDT", interval: "1h").then((value) {
    //   setState(() {
    //     candles = value;
    //   });
    //   print(value[0].date);
    // });
    getData('1day');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Candlestick'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Container(
                    // child: Candlesticks(
                    //   candles: candles,
                    // ),
                    child: KChartWidget(
                      datas,
                      chartStyle,
                      chartColors,
                      isLine: isLine,
                      mainState: _mainState,
                      volHidden: _volHidden,
                      secondaryState: _secondaryState,
                      fixedLength: 2,
                      timeFormat: TimeFormat.YEAR_MONTH_DAY,
                      isChinese: false,
                      // ignore: prefer_const_literals_to_create_immutables
                      maDayList: [1, 100, 1000],
                      isOnDrag: (isDrag) {},
                      onLoadMore: (bool a) {},
                      onSecondaryTap: () {},
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Main State'),
              ),
              Expanded(
                  child: Container(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Text('isLine:'),
                              Checkbox(
                                value: isLine,
                                onChanged: (value) {
                                  setState(() {
                                    isLine = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Hide Volume:'),
                              Checkbox(
                                value: _volHidden,
                                onChanged: (value) {
                                  setState(() {
                                    _volHidden = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Text('MA'),
                              Radio(
                                  value: MainState.MA,
                                  groupValue: _mainState,
                                  onChanged: (MainState? state) {
                                    setState(() {
                                      _mainState = state!;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('BOLL'),
                              Radio(
                                  value: MainState.BOLL,
                                  groupValue: _mainState,
                                  onChanged: (MainState? state) {
                                    setState(() {
                                      _mainState = state!;
                                    });
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('NONE'),
                              Radio(
                                  value: MainState.NONE,
                                  groupValue: _mainState,
                                  onChanged: (MainState? state) {
                                    setState(() {
                                      _mainState = state!;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Secondary State:'),
                          DropdownButton<SecondaryState>(
                            value: dropdownValue,
                            iconSize: 12,
                            elevation: 8,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (SecondaryState? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                _secondaryState = newValue;
                              });
                            },
                            items: SecondaryState.values
                                .map<DropdownMenuItem<SecondaryState>>(
                                    (SecondaryState value) {
                              return DropdownMenuItem<SecondaryState>(
                                value: value,
                                child: Text(describeEnum(value)),
                              );
                            }).toList(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  // Future<List<Candle>> fetchCandles(
  //     {required String symbol, required String interval}) async {
  //   final uri = Uri.parse(
  //       "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=1000");
  //   final res = await http.get(uri);
  //   return (jsonDecode(res.body) as List<dynamic>)
  //       .map((e) => Candle.fromJson(e))
  //       .toList()
  //       .reversed
  //       .toList();
  // }

  void getData(String period) {
    final Future<String?> future = getIPAddress(period);
    future.then((String? result) {
      final Map parseJson = json.decode(result!) as Map<dynamic, dynamic>;
      final list = parseJson['data'] as List<dynamic>;
      datas = list
          .map((dynamic item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(datas!);
      // showLoading = false;
      setState(() {});
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((Object exception) {
      // showLoading = false;
      // setState(() {});
      print('### datas error $exception');
    });
  }

  //Fetch data from Houbi
  Future<String?> getIPAddress(String? period) async {
    final url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
    late String result;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        result = response.body;
      } else {
        print('Failed getting IP address');
      }
      return result;
    } catch (e) {
      print('Error:$e');
      return null;
    }
  }
}
