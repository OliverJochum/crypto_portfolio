import 'package:crypto_portfolio/viewmodels/holdings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:crypto_portfolio/views/header_screen.dart';

import '../models/wallet.dart';
import '../viewmodels/header_viewmodel.dart';

class HoldingsScreen extends StatefulWidget {
  final HoldingsViewModel holdingsViewModel;
  final HeaderViewModel headerViewModel;
  const HoldingsScreen({super.key, required this.holdingsViewModel, required this.headerViewModel});
  @override

  // ignore: library_private_types_in_public_api
  _HoldingScreenState createState() => _HoldingScreenState();
}

class _HoldingScreenState extends State<HoldingsScreen> {
  final String _currency = "USD";

  
  late List<Future<String>> futureAmounts;
  late List<Future<String>> futureValues;

  @override
  void initState(){
    super.initState();

    futureAmounts = getFutureAmounts(widget.holdingsViewModel.getWallets());
    futureValues = getFutureValues(widget.holdingsViewModel.getWallets());
  }

  //widget.holdingsViewModel.getAmount(widget.holdingsViewModel.getWallets()[index])
  List<Future<String>> getFutureAmounts(List<Wallet> wallets) {
    
    List<Future<String>> list = List<Future<String>>.empty(growable: true);
    
    for(Wallet wallet in wallets){
      list.add(widget.holdingsViewModel.getAmountFuture(wallet));
    }

    return list;
  }

  //widget.holdingsViewModel.getValue(widget.holdingsViewModel.getWallets()[index], _currency)
  List<Future<String>> getFutureValues(List<Wallet> wallets) {
    
    List<Future<String>> list = List<Future<String>>.empty(growable: true);
    
    for(Wallet wallet in wallets){
      list.add(widget.holdingsViewModel.getValueFuture(wallet, _currency));
    }

    return list;
  }


  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          HeaderScreen(headerViewModel: widget.headerViewModel,),
          Placeholder(
            fallbackHeight: 200,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.holdingsViewModel.getWallets().length,
              padding: EdgeInsets.all(10.0),
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index){
                return currencyItem(context, index);
              },),
          )
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50.0,
        child:Row(children: [
          FlutterLogo(size: 50.0),
          Spacer(),
          FlutterLogo(size: 50.0),
          Spacer(),
          FlutterLogo(size: 50.0),
          Spacer(),
          FlutterLogo(size: 50.0),
          ],))
        ),
    );
  }

  Widget currencyItem(BuildContext context, int index){
  return Card(
    child: Row(
      children: <Widget>[
        const FlutterLogo(size: 10.0,),
        Column(
          children: [
            Text(widget.holdingsViewModel.getWallets()[index].network),
            // Text(widget.holdingsViewModel.getAmount(widget.holdingsViewModel.getWallets()[index]))
            FutureBuilder<String?>(
              future: futureAmounts[index],
              builder: (context, snapshot){
                if(snapshot.hasError){
                  final error = snapshot.error;

                  return Text('$error');
                }
                else if(snapshot.hasData){
                  String data = snapshot.data!;

                  return Text(data);
                }
                else{
                  return const CircularProgressIndicator();
                }
              })
          ],
        ),
        Row(
          children: [
            // Text(widget.holdingsViewModel.getValue(widget.holdingsViewModel.getWallets()[index], _currency))
            FutureBuilder(
              future: futureValues[index],
              builder: (context, snapshot){
                if(snapshot.hasError){
                  final error = snapshot.error;

                  return Text('$error');
                }
                else if(snapshot.hasData){
                  String data = snapshot.data!;

                  return Text(data);
                }
                else{
                  return const CircularProgressIndicator();
                }
              })
          ],
        )
      ],
    ),
  );
}
}

