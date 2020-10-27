

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_ui/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/MainScreen.dart';
import 'package:mobile_app/auth.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/user_detail.dart';
import 'Accueil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class AuthChoix extends StatefulWidget {
  @override
  _AuthChoixState createState() => _AuthChoixState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

FirebaseUser _user;

class _AuthChoixState extends State<AuthChoix> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  bool isSignIn = false;
  var _formKey = GlobalKey<FormState>();

  String name;
  String email;
  String password;




  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      //  backgroundColor: Colors.transparent,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(220, 234, 232, 1),
        elevation: 0.0,
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) =>MainScreen()));
                },
              );
            },
          ),
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
          ),
          SingleChildScrollView(
            child: new Container(
              color: Colors.transparent,
                padding: EdgeInsets.only(top: 0, left: 20, right: 0),
                child: new Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 40.0, 20.0, 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: Text('Connectez-vous à votre \nCompte', style: TextStyle(
                            fontSize: 40,
                            height: 1.3,
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                      new Container(
                          padding: EdgeInsets.fromLTRB(0.0, 30.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent,

                          ),
                          child: new ButtonTheme(
                            minWidth: 370,
                            height:47,
                            child : RaisedButton(
                                onPressed: () => signInGoogle().whenComplete(() => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Accueil(),),
                                )),
                                color: Color.fromRGBO(243, 243, 243, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Row(
                                  children:[
                                    Container(
                                        padding: EdgeInsets.only(left: 20.0)
                                    ),
                                    IconTheme(
                                      data: IconThemeData(color: Colors.red),
                                      child: Image(image: AssetImage("images/gmail.png"),),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 28.0)
                                    ),
                                    new Text(
                                    'Continuer avec Google',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black
                                    ),
                                  ),
                                    ]
                                ),
                            ),
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.fromLTRB(0.0, 27.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent,

                          ),
                          child: new ButtonTheme(
                            minWidth: 370,
                            height:47,
                            child : RaisedButton(
                                onPressed: (){
                                  signInFacebook();
                                },
                                color: Color.fromRGBO(59, 89, 152, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 20.0)
                                    ),
                                    IconTheme(
                                      data: IconThemeData(color: Colors.red),
                                      child: Image(image: AssetImage("images/facebook.png"),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 28.0)
                                    ),
                                    new Text(
                                      'Continuer avec Facebook',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.fromLTRB(0.0, 27.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child: new ButtonTheme(
                            minWidth: 370,
                            height:47,
                            child : RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Auth(),),
                                  );
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: new Text(
                                  'Se Connecter avec l\'adresse mail',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                  ),
                                )
                            ),
                          )
                      )
                    ]
                ),
              ),
            ),



        ],
      ),

    );
  }

// Fonctio de connexion par gmail
  Future<bool> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount != null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(idToken : googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);
      AuthResult result = await auth.signInWithCredential(credential); // to add user to firebase
      FirebaseUser user = await result.user;
      name = user.displayName;
      email = user.email;
      FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      print(user.uid);
      print('\n Le nom esttttttttttttttttttttttt'+ name);
      print('\n Le mail esttttttttttttttttttttttt'+ email);
     Future.value(true);
      //navigateToDetail(User('', 'inconnu', email,'inconnu', '01010101', '', 0, 2), 'Add User');
    }


  }

  // fait appel à la fonction qui ajoute un étudiant depuis database_helper
  void navigateToDetail(User user, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserDetail(user, title);
    }));

    if (result == true) {
      print('Etudiant ajouté');
    }
  }


// fonction de connexion depuis facebook
  Future<void> signInFacebook() async{
    try{
      FacebookLogin facebookLogin = new FacebookLogin();
      final result = await facebookLogin.logIn(['email','public_profile']);
      final token = result.accessToken.token;
      final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
      print(graphResponse.body);

      if(result.status == FacebookLoginStatus.loggedIn){
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token,);
        _auth.signInWithCredential(credential);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                Accueil(),),
        );
      }
    }catch(e){print(e.message);}
    /* return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new SimpleDialog(
              title: Text('Erreur'),
              children:<Widget> [
                new Text(e.message),
                new FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Ok')
                )

              ],
            );
          }
      );
    }*/


  }

}