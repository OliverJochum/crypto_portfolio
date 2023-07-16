import 'package:crypto_portfolio/models/btcWallet.dart';
import 'package:crypto_portfolio/models/wallet.dart';

class User{
  double value = 0.0;

  List<Wallet> wallets = List<Wallet>.empty(growable: true);

  User.empty(){
    value = 0.0;
    wallets = List<Wallet>.empty(growable: true);
  }
  User(this.value, this.wallets);

  Wallet newBTCWallet(String address, String network){

    if (network != "BTC") throw ("Network is incorrect. Expected: 'BTC' ");

    Wallet wallet = BtcWallet(address);
    wallets.add(wallet);

    return wallet;
  }

  Future<double> calculateValue(String currency) async{
    for(Wallet wallet in wallets){
      value += await wallet.getValue(currency);
    }
    return value;
  }
}

