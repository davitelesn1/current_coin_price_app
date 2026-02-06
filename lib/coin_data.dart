import 'dart:convert';
import 'package:http/http.dart' as http;

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'b3f8f5bf-2abf-42d3-8954-320e6ae1c917';

class CoinData {
  Future getCoinData(String crypto, String selectedCurrency) async {
    if (apiKey.isEmpty) {
      throw 'Missing COINAPI_KEY. Run with: flutter run --dart-define=COINAPI_KEY=YOUR_KEY';
    }
    String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
    print(requestURL);
    http.Response response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}

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
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'USDT', 'BNB', 'XRP', 'SOL', 'DOT', ];