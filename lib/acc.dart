import 'package:flutter/material.dart';


class Acc extends StatefulWidget {
  const Acc({Key key}) : super(key: key);

  @override
  _AccState createState() => _AccState();
}

class _AccState extends State<Acc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('c\'est l\'accueil'),
    );
  }

}

