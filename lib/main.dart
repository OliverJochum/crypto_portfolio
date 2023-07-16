
import 'package:crypto_portfolio/viewmodels/header_viewmodel.dart';
import 'package:crypto_portfolio/viewmodels/holdings_viewmodel.dart';
import 'package:crypto_portfolio/viewmodels/wallets_viewmodel.dart';
import 'package:crypto_portfolio/views/holdings_screen.dart';
import 'package:crypto_portfolio/views/wallets_screen.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'views/holdings_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Crypto App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    User user = User.empty();
    user.newBTCWallet("18cBEMRxXHqzWWCxZNtU91F5sbUNKhL5PX", "BTC");
    user.newBTCWallet("3D2oetdNuZUqQHPJmcMDDHYoqkyNVsFk9r", "BTC");
    WalletsViewModel walletsViewModel = WalletsViewModel(user: user);
    HoldingsViewModel holdingsViewModel = HoldingsViewModel(user: user);
    HeaderViewModel headerViewModel = HeaderViewModel(user: user);
    return Scaffold(
      body: HoldingsScreen(holdingsViewModel: holdingsViewModel,headerViewModel: headerViewModel,)
      );
    
  }
}
