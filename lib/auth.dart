import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_ui/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile_app/AccueilProf.dart';
import 'package:mobile_app/acc.dart';
import 'package:mobile_app/auth_choix.dart';
import 'package:mobile_app/inscription.dart';
import 'package:mobile_app/models/chapitre.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:mobile_app/screens/user_detail.dart';
import 'package:mobile_app/screens/user_list.dart';
import 'package:sqflite/sqflite.dart';
import 'Accueil.dart';
import 'inscription.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';


class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

FirebaseUser _user;

class _AuthState extends State<Auth> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  FirebaseUser _currentUser;
  String name, email , password ;
  bool isSignIn = false;
  var _formKey = GlobalKey<FormState>();




  @override
  void initState() {
    super.initState();
    isSignIn = false;
    checkCurrentUser();
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
                    (context) =>AuthChoix()));
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

              // FORMULAIRE D'AUTHENTIFICATION

              child : Form(
                key: _formKey,
                child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: Column(
                          children:<Widget> [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: TextFormField(
                                // decoration: new InputDecoration(hintText: "adresse mail"),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (item){
                                  setState((){
                                    email = item;
                                  });
                                },

                                //VERIFICATION DU CHAMP D'ADRESSE MAIL

                                validator: (item){
                                  return item.contains("@") ? null : "Entrez une adresse mail valide";
                                },
                                // onSubmitted: (String string){},*/
                                decoration: new InputDecoration(
                                    hintText: "adresse mail",
                                    //  border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                        data: IconThemeData(color: Colors.red),
                                        child: Icon(Icons.email),
                                      ),
                                      padding: EdgeInsets.only(left: 25, right: 10),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(20.0, 37.0, 20.0, 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: Column(
                          children:<Widget> [
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black87
                                      )
                                  )
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                obscureText: true,
                                onSaved: (item){
                                  setState((){
                                    password = item;
                                  });
                                },

                                //VERIFICATION DU CHAMP DE MDP QUI DOIT ETRE   6 <= MDP <= 15

                                validator: (item){
                                  return item.length>5 && item.length<=15 ? null : "Le mot de passe doit etre compris entre 6 et 15 caractères";
                                },
                                decoration: new InputDecoration(
                                    hintText: "mot de passe",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Padding(
                                      child: IconTheme(
                                          data: IconThemeData(color: Colors.red),
                                          child: Icon(Icons.lock_outline)
                                      ),
                                      padding: EdgeInsets.only(left: 25, right: 10),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Le BOUTTON DE CONNEXION

                      new Container(
                          padding: EdgeInsets.fromLTRB(35.0, 60.0, 20.0, 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child: new ButtonTheme(
                            minWidth: 190,
                            height:45,
                            child : RaisedButton(
                                onPressed: () {
                                  signInMail(email,password) ;
                                },
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: new Text(
                                  'Se Connecter',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                  ),
                                )
                            ),
                          )
                      ),

                      //INSCRIPTION DE L'ETUDIANT

                      new Container(
                          padding: EdgeInsets.fromLTRB(25.0, 155.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "Vous n'avez pas de compte ?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15
                                    ),),
                                  TextSpan(text: 'Inscrivez-vous.',
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        debugPrint('FAB clicked');
                                        navigateToDetail(User('', '', '','', ''), 'Add Note');
                                      }
                                      ,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ]
                            ),
                          )
                      )
                    ]
                ),
              ),
            ),
          )
        ],
      ),

    );
  }

// FONCTION QUI FAIT APPEL A LA FONCTION D'AJOUT D'UN ETUDIANT DANS LE DATABASE_HELPER
  void navigateToDetail(User user, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserDetail(user, title);
    }));

  }

//FONCTION D'INSCRIPTION PAR ADRESSE MAIL
  Future<bool> signInMail(String email, String password)async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        AuthResult result = await auth.signInWithEmailAndPassword(
            email: email, password: password); // FirebaseUser
        FirebaseUser user = result.user;
        name = user.displayName;
        print('connecté en temps queeeeee ${name} et email ${email}');
        if (email == 'ibtihal@gmail.com') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AccueilProf(),),);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Accueil(),),);
        }
        // return Future.value(true);
      } catch (e) {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new SimpleDialog(
                title: Text('Erreur'),
                children: <Widget>[
                  new Text(e.message != null ? e.message : ''),
                  new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok')
                  )
                ],
              );
            }
        );
      }
    }

  }



  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

//FONCTION DE VERIFICATION DE L'UTILISATEUR ACTUEL
  void checkCurrentUser() async{
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }





}