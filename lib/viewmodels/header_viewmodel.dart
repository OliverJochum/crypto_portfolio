import 'package:flutter/material.dart';

import '../models/user.dart';

class HeaderViewModel with ChangeNotifier{
  final User _user;

  HeaderViewModel({required User user}) : _user = user;

  Future<double> getHoldingsFuture(String currency) async{
    return await _user.calculateValue(currency);
  }

  double getHoldings(String currency){
    double out = 0.0;

    getHoldingsFuture(currency).then((value) => out = value);

    return out;
  }


}