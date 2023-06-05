
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypto_portfolio/models/transaction.dart';
import 'package:crypto_portfolio/models/wallet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BtcWallet implements Wallet{
  @override
  String address;

  @override
  List<Transaction> transactions = List<Transaction>.empty();

  @override
  Map<String, dynamic> data = {};

  String url = "https://graphql.bitquery.io/";

  @override
  Future<double> getAmount() async {
    String amountQuery = r'''
      query ($network: BitcoinNetwork!,
          $address:String!
          $from: ISO8601DateTime,
          $till: ISO8601DateTime){
            bitcoin(network: $network ){
              inputs(
                date: {
                                since: $from
                                till: $till}
                inputAddress: {is: $address}
              ){
                count
                value

                min_date: minimum(of: date)
                max_date: maximum(of: date)
              }

              outputs(
                date: {
                                since: $from
                                till: $till}
                outputAddress: {is: $address}
              ){
                count
                value

                min_date: minimum(of: date)
                max_date: maximum(of: date)


              }


            }
          }
    ''';

    String variables = '''
    {"limit":10,"offset":0,"network":"bitcoin","address":"$address","from":null,"till":null,"dateFormat":"%Y-%m"}
    ''';
    await apiRequest(url, amountQuery,variables);

    double inputs = data['data']['bitcoin']['inputs'][0]['value'];
    double outputs = data['data']['bitcoin']['outputs'][0]['value'];
    double amount = outputs-inputs;
    return amount;
  }

  @override
  double getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  
  @override
  Future<void> apiRequest(String url, String query, String variables) async {
    final gqlUrl = Uri.parse(url);
    final headers = {
      "X-API-KEY": dotenv.env['API_KEY']!,
      "Content-Type": "application/json",
    };
    final bodyy = {
      "query": query,
      "variables": variables
    };
    final body = jsonEncode(bodyy);
    final response = await http.post(
      gqlUrl,
      headers: headers,
      body: body,
    );
    print(response.body);
    data = jsonDecode(response.body);
}
  BtcWallet(this.address);
}

