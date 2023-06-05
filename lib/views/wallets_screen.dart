import 'package:flutter/material.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallets'),
      ),
      body: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          shrinkWrap: false,
          itemBuilder: (BuildContext context, int index) {
            return walletItem(context, index);
          },
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 50.0,
              child: Row(
                children: [
                  FlutterLogo(size: 50.0),
                  Spacer(),
                  FlutterLogo(size: 50.0),
                  Spacer(),
                  FlutterLogo(size: 50.0),
                  Spacer(),
                  FlutterLogo(size: 50.0),
                ],
              ))),
    );
  }
}

Widget walletItem(BuildContext context, int index) {
  return Card(
    child: Row(
      children: <Widget>[],
    ),
  );
}
