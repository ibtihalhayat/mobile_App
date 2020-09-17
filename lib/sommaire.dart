import 'package:flutter/material.dart';

class Sommaire extends StatefulWidget {
  @override
  _SommaireState createState() => _SommaireState();
}

class _SommaireState extends State<Sommaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      body: Text('voici le sommaire'),
    );
  }
}
