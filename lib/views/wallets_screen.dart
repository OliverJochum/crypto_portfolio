import 'package:crypto_portfolio/viewmodels/wallets_viewmodel.dart';
import 'package:flutter/material.dart';

class WalletsScreen extends StatefulWidget {
  final WalletsViewModel walletsViewModel;
  
  const WalletsScreen({super.key, required this.walletsViewModel});

  @override
  // ignore: library_private_types_in_public_api
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {


  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _networkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallets'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.walletsViewModel.getWallets().length,
              padding: EdgeInsets.all(10.0),
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                return walletItem(context, index);
              },
            ),
          ),
          ElevatedButton(
            onPressed: (){_addWalletDialog(context);},
             child: const Text("Add Wallet")
             ),
        ],
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

  Future<void> _addWalletDialog(BuildContext context) async{
  return showDialog(context: context,
   builder: (context) {
    return AlertDialog(
      title: const Text('New Wallet'),
      content: Column(
        children: [
          TextField(
            onSubmitted: (value) {
              // widget.walletsViewModel.updateAddressFromTextfield(value);
            },
            controller: _addressController,
            decoration: const InputDecoration(hintText: "Address"),
          ),
          TextField(
            onSubmitted: (value) {
              // widget.walletsViewModel.updateNetworkFromTextfield(value);
            },
            controller: _networkController,
            decoration: const InputDecoration(hintText: "Network"),
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Add Wallet'),
            onPressed: (){
              setState(() {
                widget.walletsViewModel.addWallet(_addressController.text, _networkController.text);
                Navigator.pop(context);

                _addressController.clear();
                _networkController.clear();
              });
            }
            )
        ],
      ),
    );
   }
   );
}

Widget walletItem(BuildContext context, int index) {
  return Card(
    child: Row(
      children: <Widget>[
        Column(
          children: [
            const Text("Address"),
            Text(widget.walletsViewModel.getWallets()[index].address),
            const Text("Network"),
            Text(widget.walletsViewModel.getWallets()[index].network),
          ],
        )
        ]
        ),
        );
}
}





