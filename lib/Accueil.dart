import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Accueil extends StatelessWidget{

 // final FirebaseUser user;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Accueil'),
      ),
      body: new RaisedButton(
          onPressed: (){},
       child: Text('Log Out'),
      ),

    );

  }


}