import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/wallet.dart';

class WalletsViewModel with ChangeNotifier{
  final User _user;
  String? _address;
  String? _network;
  

  WalletsViewModel({required User user}) : _user = user;

  void addWallet(String address, String network){
    switch(network){
      case "BTC":
        _user.newBTCWallet(address, network);
      break;
    }
    
  }

  void updateAddressFromTextfield(String newAddress){
    _address = newAddress;
  }
  void updateNetworkFromTextfield(String newNetwork){
    _network = newNetwork;
  }

  List<Wallet> getWallets(){
    return _user.wallets;
  }
}