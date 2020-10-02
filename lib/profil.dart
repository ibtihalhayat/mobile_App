
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/auth.dart';
import 'MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Profil extends StatelessWidget{

  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogIn = FacebookLogin();


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Stack(
        children:<Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(20.0, 250.0, 20.0, 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent
            ),
              child: new ButtonTheme(
                minWidth: 400,
                height:45,
                child : RaisedButton(
                    onPressed: () {
                    },
                    //color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: new Text(
                      'Changer l\'adresse mail',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    )
                ),
              )
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(20.0, 315.0, 20.0, 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.transparent
              ),
              child: new ButtonTheme(
                minWidth: 400,
                height:45,
                child : RaisedButton(
                    onPressed: () {
                    },
                    //color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: new Text(
                      'Changer le mot de passe',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    )
                ),
              )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(200.0, 400.0, 20.0, 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent
            ),
            child: ButtonTheme(
              minWidth: 200,
              height:45,
              child: new RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                  onPressed:(){
                    googleSignOut().whenComplete(() =>
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
                    );
                    /*facebookSignOut().whenComplete(() =>
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
                    );*/

                  },
               child: Text('Se Deconnecter',
                 style: TextStyle(
                     fontSize: 20,
                     color: Colors.black
                 ),),
              ),
            ),
          ),
        ]
      ),
    );
  }


  Future<void> googleSignOut() async {
    //FirebaseUser user = await auth.currentUser();
  //  try {
      await auth.signOut();
      await googleSignIn.disconnect();
     // await googleSignIn.signOut();
  /*  }catch(e){
      print(e.message);
    }*/

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