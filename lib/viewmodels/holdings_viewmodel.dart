import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/wallet.dart';

class HoldingsViewModel with ChangeNotifier{
  final User _user;

  HoldingsViewModel({required User user}) : _user = user;

  List<Wallet> getWallets(){
    return _user.wallets;
  }

  Future<String> getAmountFuture(Wallet wallet) async{
    double amount = await wallet.getAmount();

    return amount.toString();
  }

  String getAmount(Wallet wallet){
    String out = "";

    getAmountFuture(wallet).then((value) => out = value);

    print(out);
    return out;
  }



  Future<String> getValueFuture(Wallet wallet, String currency) async{
    double value = await wallet.getValue(currency);

    return value.toString();
  }

  String getValue(Wallet wallet, String currency){
    String out = "";

    getValueFuture(wallet, currency).then((value) => out = value);
    print(out);
    return out;
  }
}