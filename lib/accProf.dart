import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_app/auth.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/module_listuser.dart';


class AccProf extends StatefulWidget {

  String nomUser;
  String emailUser;
  AccProf({this.nomUser, this.emailUser});

  @override
  _AccProfState createState() => _AccProfState(nomUser,emailUser);
}

class _AccProfState extends State<AccProf> {

  String nomUser;
  String emailUser;
  _AccProfState(this.nomUser, this.emailUser);

  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogIn = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(220, 234, 232, 1),
        elevation: 0.0,

        // ICONE DE DECONNEXION
        actions: [
          Builder(
           builder: (BuildContext context){
            return IconButton(
              icon: const Icon(Icons.logout),
              onPressed: (){
                googleSignOut().whenComplete(() =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
                );
                facebookSignOut().whenComplete(() =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Auth()))
                );
              },
            );
          },
        ),
        ]
      ),
      body: Stack(
          children:<Widget> [
            new Container(
              decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
            ),
            SingleChildScrollView(

              // MESSAGE DE BIENVENUE
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Bienvenue", style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text('Selectionnez votre \n Choix', style: TextStyle(
                        fontSize: 35,
                        height: 1.3,
                        fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ),

            // CHOIX DU PROF
            Container(
                padding: EdgeInsets.only(top: 255, left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent
                ),
                child: Card(
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child :ListTile(
                    title: Container(
                      padding: EdgeInsets.only( left: 10),
                      child: Text('Ajouter un Module',style: TextStyle(fontSize: 28,color: Colors.black, fontStyle: FontStyle.italic)),
                    ),
                    onTap: (){
                      navigateToDetailm(Module('', ''), 'Add Module');
                    },
                  ),
                )
            ),

        ]

        ),

    );
  }

// FONCTION QUI FAIT APPEL A LA FONCTION D'AJOUT D'UN MODULE DANS LE DATABASE_HELPER
  void navigateToDetailm(Module module, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ModuleDetail(module, title);
    }));

  }

  // DECONNEXION DEPUIS LE COMPTE GOOGLE
  Future<void> googleSignOut() async {
    //FirebaseUser user = await auth.currentUser();
    //  try {
    await auth.signOut();
    await googleSignIn.disconnect();
    // await googleSignIn.signOut();
  }

  // DECONNEXION DEPUIS LE COMPTE FACEBOOK
  Future<void> facebookSignOut() async {
    await facebookLogin.logOut();
  }

}

