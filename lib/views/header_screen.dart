import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget{
  const HeaderScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var currency = 'f';

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
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Expanded(
            child: Row(children: [
              const Spacer(),
              const Icon(Icons.attach_money),
              const Spacer(),
              Text(currency),
              const Spacer(),
              ElevatedButton(onPressed: onPressed, child: const Icon(Icons.arrow_circle_down)),
              const Spacer()
            ],),
          ),
        )
      ],
    );
  }
}