import 'package:flutter/material.dart';
import 'MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Center(
        child: new RaisedButton(
            onPressed:(){
              signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MainScreen()));
            },
         child: Text('Se Deconnecter'),
        ),
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

}