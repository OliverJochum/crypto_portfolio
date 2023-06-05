import 'package:flutter/material.dart';
import 'package:crypto_portfolio/views/header_screen.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({Key? key}) : super(key: key);
  @override

  // ignore: library_private_types_in_public_api
  _HoldingScreenState createState() => _HoldingScreenState();
}

class _HoldingScreenState extends State<HoldingsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          HeaderScreen(),
          Placeholder(
            fallbackHeight: 200,
          ),
          Expanded(
            child: ListView.builder(
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
}

Widget currencyItem(BuildContext context, int index){
  return Card(
    child: Row(
      children: <Widget>[
        
      ],
    ),
  );
}