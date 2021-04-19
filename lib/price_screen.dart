import 'dart:io' show Platform;

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
  CoinData data = CoinData();
  Map<String, String> prices = {};
  DropdownButton androidDropdown() {
    List<DropdownMenuItem> menuItems = [];
    for (String currency in currenciesList) {
      menuItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return DropdownButton(
      value: selectedCurrency,
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> menuItems = [];
    for (String currency in currenciesList) {
      menuItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        selectedCurrency = currenciesList[index];
        getData();
      },
      children: menuItems,
    );
  }

  void getData() async {
    setState(() {
      for (String cryptoCurrency in cryptoList) prices[cryptoCurrency] = '?';
    });
    try {
      var newPrices = await data.getCoinData(selectedCurrency);
      setState(() {
        prices = newPrices;
      });
    } catch (e) {
      print(e);
    }
  }

  List<CryptoCard> getCryptoCards() {
    List<CryptoCard> cards = [];
    for (String cryptoCurrency in cryptoList) {
      cards.add(CryptoCard(
        cryptoCurrency: cryptoCurrency,
        selectedCurrency: selectedCurrency,
        cryptoPrice: prices[cryptoCurrency],
      ));
    }
    return cards;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropdown() : iosPicker(),
          ),
        ],
      ),
    );
  }
}
