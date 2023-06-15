import 'package:crypto_portfolio/models/transaction.dart';

abstract class Wallet{
  String address;
  List<Transaction> transactions = List<Transaction>.empty();
  Map<String, dynamic> data = {};
  String url = "https://graphql.bitquery.io/";


  Future<double> getAmount(); //return the amount of cryptocurrency in that currency
  Future<double> getValue(String currency); //return the value of the cryptocurrency as a dollar amount
  Future<List<Transaction>> getTransactions(DateTime from, DateTime till);
  Future<List<Transaction>> getAllTransactions();

  Future<void> apiRequest(String url, String query,String variables);

  Wallet(this.address);
}