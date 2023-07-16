import 'package:crypto_portfolio/viewmodels/header_viewmodel.dart';
import 'package:flutter/material.dart';

class HeaderScreen extends StatefulWidget{
  final HeaderViewModel headerViewModel;
  
  const HeaderScreen({super.key, required this.headerViewModel});

  @override
  // ignore: libgrary_private_types_in_public_api
  _HeaderScreenState createState()=> _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen>{

  @override
  Widget build(BuildContext context) {
    var currency = '123456';

    void onPressed(){

    }
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: IconButton(onPressed: onPressed, icon: Image.asset('assets/images/app_logo.png',width: 50,height: 50)),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
          
            child: Row(children: [
              const Spacer(),
              const Icon(Icons.attach_money),
              const Spacer(),
              Text(currency),
              const Spacer(),
              ElevatedButton(onPressed: onPressed, child: const Icon(Icons.arrow_circle_down)),
              const Spacer()
            ],),
        )
      ],
    );
  }
}