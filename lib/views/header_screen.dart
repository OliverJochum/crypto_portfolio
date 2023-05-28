import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPressed, icon: Image.asset('app_logo.png')),
        Row(children: [
          Icon(icon),
          Text(data),
          ElevatedButton(onPressed: onPressed, child: child)
        ],)
      ],
    );
  }
}