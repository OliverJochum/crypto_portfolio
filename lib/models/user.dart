import 'package:crypto_portfolio/models/wallet.dart';

class User{
  double value;

  List<Wallet> wallets;

  User(this.value, this.wallets);
}