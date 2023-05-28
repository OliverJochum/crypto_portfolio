import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var currency = 'f';
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPressed, icon: Image.asset('app_logo.png')),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Row(children: [
            Icon(icon),
            Text(currency),
            ElevatedButton(onPressed: onPressed, child: child)
          ],),
        )
      ],
    );
  }
}