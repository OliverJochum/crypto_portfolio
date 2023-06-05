import 'package:flutter/material.dart';
import 'package:crypto_portfolio/views/header_screen.dart';

class TransferHistoryScreen extends StatefulWidget{
  const TransferHistoryScreen({Key? key}) : super(key: key);

  @override

  // ignore: library_private_types_in_public_api
  _TransferHistoryScreenState createState() => _TransferHistoryScreenState();
}

class _TransferHistoryScreenState extends State<TransferHistoryScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderScreen(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index){
                return transferItem(context, index);
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

Widget transferItem(BuildContext context, int index){
  return Card(
    child: Row(
      children: <Widget>[
        
      ],
    ),
  );
}