import 'package:flutter/material.dart';

class Accueil extends StatelessWidget{
  String message;
  Accueil(String message){
    this.message = message;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Accueil'),
      ),

    );

  }


}