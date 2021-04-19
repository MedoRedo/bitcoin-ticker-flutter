import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '62D86C45-3D4F-4C0D-A33E-4565FD05BEBE';

class CoinData {
  Future getCoinData(String selectedCoin) async {
    String url = '$coinAPIURL/BTC/$selectedCoin';
    http.Response response =
        await http.get(url, headers: {'X-CoinAPI-Key': apiKey});
    var data = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(data);
    }
  }
}
