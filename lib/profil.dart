
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/auth.dart';
import 'MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Profil extends StatelessWidget{

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogIn = FacebookLogin();


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Center(
        child: new RaisedButton(
            onPressed:(){
              googleSignOut().whenComplete(() =>
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
              );
              facebookSignOut().whenComplete(() =>
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
              );

            },
         child: Text('Se Deconnecter'),
        ),
      ),
    );
  }


  Future<void> googleSignOut() async {
    //FirebaseUser user = await auth.currentUser();
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    }catch(e){
      print(e.message);
    }

/*    FirebaseUser user = await auth.currentUser();
    if(user.providerData[1].providerId == 'google.com'){
      await googleSignIn.disconnect();
    }
    await auth.signOut();
    return Future.value(true);
    await auth.signOut().then((onValue){
      googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    }
    );
*/
  }

  Future<void> facebookSignOut() async {
    await facebookLogin.logOut();

  }


/*  Future<void> signOut() async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print(e);
    }
  }
*/


}