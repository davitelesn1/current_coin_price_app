import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  List<Widget> getCupertinoItems() {
    List<Widget> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return items;
  }

  Map<String, String> cryptoValues = {'BTC': '?', 'ETH': '?', 'LTC': '?'};

  void getData() async {
    try {
      Map<String, String> newValues = {};
      for (String crypto in cryptoList) {
        double data = await CoinData().getCoinData(crypto, selectedCurrency);
        newValues[crypto] = data.toStringAsFixed(0);
      }

      setState(() {
        cryptoValues = {...cryptoValues, ...newValues};
      });
    } catch (e) {
      print(e);
    }
  }

  List<Widget> getCryptoCards() {
    List<Widget> cards = [];
    for (String crypto in cryptoList) {
      cards.add(
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: CryptoCard(
            crypto: crypto,
            bitcoinValueIn: cryptoValues[crypto] ?? '?',
            selectedCurrency: selectedCurrency,
          ),
        ),
      );
    }
    return cards;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Coin Prices')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/coinPaper.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.55)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: getCryptoCards()),
                ),
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                decoration: BoxDecoration(
                  color: scheme.surface.withOpacity(0.90),
                  border: Border(
                    top: BorderSide(
                      color: scheme.outline.withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                ),
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (selectedIndex) {
                    setState(() {
                      selectedCurrency = currenciesList[selectedIndex];
                    });
                    getData();
                  },
                  children: getCupertinoItems(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
