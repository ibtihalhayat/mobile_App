import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/MainScreen.dart';

class Accueil extends StatelessWidget{

 // final FirebaseUser user;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text('Accueil'),
      ),
      body: new RaisedButton(
          onPressed:(){
            signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MainScreen()));
          },
       child: Text('Se Deconnecter'),
      ),

    );

  }

  Future<void> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print(e);
    }
  }

 /*Future<String> getId() async {
    return (await FirebaseAuth.instance.currentUser).uid;
  }

  Future  getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }*/

}