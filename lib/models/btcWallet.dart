
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crypto_portfolio/models/transaction.dart';
import 'package:crypto_portfolio/models/wallet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BtcWallet implements Wallet{
  @override
  String address;

  @override
  String network = "BTC";

  @override
  List<Transaction> transactions = List<Transaction>.empty();

  @override
  Map<String, dynamic> data = {};

  @override
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

  Future<double> getValue(String currency) async{

    final response = await http.get( 
      Uri.parse("https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?id=1&convert=$currency"),
      headers: {
        'X-CMC_PRO_API_KEY': dotenv.env['COINMARKETCAP_API_KEY']!,
        "Accept": "application/json",
      }
    );

    data = jsonDecode(response.body);

    double btcValue = data['data']['1']['quote'][currency]['price'];
    double amount = await getAmount();


    return btcValue * amount;
  }

  
  @override
  Future<void> apiRequest(String url, String query, String variables) async {
    final gqlUrl = Uri.parse(url);
    final headers = {
      "X-API-KEY": dotenv.env['BITQUERY_API_KEY']!,
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
    
    data = jsonDecode(response.body);
}
  @override
  Future<List<Transaction>> getTransactions(DateTime from, DateTime till) async {
    List<Transaction> transactions = await getAllTransactions();

    List<Transaction> boundedTransactions = List<Transaction>.empty(growable: true);

    for(int i = 0; i < transactions.length;i++){
      if(transactions[i].timestamp.isAfter(from) && transactions[i].timestamp.isBefore(till)){
        boundedTransactions.add(transactions[i]);
      }
    }
    return boundedTransactions;
  }

  @override
  Future<List<Transaction>> getAllTransactions() async{
    String transactionQuery = r'''
            query ($network: BitcoinNetwork!, $address: String!, $inboundDepth: Int!, $outboundDepth: Int!, $limit: Int!, $from: ISO8601DateTime, $till: ISO8601DateTime) {
  bitcoin(network: $network) {
    inbound: coinpath(
      initialAddress: {is: $address}
      depth: {lteq: $inboundDepth}
      options: {direction: inbound, asc: "depth", desc: "amount", limitBy: {each: "depth", limit: $limit}}
      date: {since: $from, till: $till}
    ) {
      sender {
        address
        annotation
      }
      receiver {
        address
        annotation
      }
      amount
      depth
      count
      transactions {
        timestamp
      }
    }
    outbound: coinpath(
      initialAddress: {is: $address}
      depth: {lteq: $outboundDepth}
      options: {asc: "depth", desc: "amount", limitBy: {each: "depth", limit: $limit}}
      date: {since: $from, till: $till}
    ) {
      sender {
        address
        annotation
      }
      receiver {
        address
        annotation
      }
      amount
      depth
      count
      transactions {
        timestamp
      }
    }
  }
}

      ''';

    String variables = '''{
      "inboundDepth": 1,
      "outboundDepth": 1,
      "limit": 100,
      "offset": 0,
      "network": "bitcoin",
      "address": "$address",
      "from": null,
      "till": null,
      "dateFormat": "%Y-%m"
      }''';

      await apiRequest(url, transactionQuery, variables);


      List<Transaction> inbound = List<Transaction>.empty(growable: true);
      List<Transaction> outbound = List<Transaction>.empty(growable: true);

      for(int i = 0; i < data['data']['bitcoin']['inbound'].length; i++){
        String sender = data['data']['bitcoin']['inbound'][i]['sender']['address'];
        String receiver = data['data']['bitcoin']['inbound'][i]['receiver']['address'];
        double amount =  data['data']['bitcoin']['inbound'][i]['amount'];
        DateTime timestamp = DateTime.parse(data['data']['bitcoin']['inbound'][i]['transactions'][0]['timestamp']);
        Transaction temp = Transaction(sender, receiver, amount, timestamp);
        inbound.add(temp);
      }

      for(int i = 0; i < data['data']['bitcoin']['outbound'].length; i++){
        String sender = data['data']['bitcoin']['outbound'][i]['sender']['address'];
        String receiver = data['data']['bitcoin']['outbound'][i]['receiver']['address'];
        double amount =  data['data']['bitcoin']['outbound'][i]['amount'];
        DateTime timestamp = DateTime.parse(data['data']['bitcoin']['outbound'][i]['transactions'][0]['timestamp']);
        Transaction temp = Transaction(sender, receiver, amount,timestamp);
        outbound.add(temp);
      }

      List<Transaction> transactions = List.from(inbound)..addAll(outbound);

      transactions.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
    return transactions;
  }

  BtcWallet(this.address);
  
}


