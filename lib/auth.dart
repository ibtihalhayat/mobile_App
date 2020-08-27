

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile_app/inscription.dart';
import 'Accueil.dart';
import 'inscription.dart';
import 'package:google_sign_in/google_sign_in.dart';



class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

FirebaseUser _user;

class _AuthState extends State<Auth> {
  String email , password ;

  bool isSignIn = false;

  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    isSignIn = false;
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomInset: true,
       // resizeToAvoidBottomPadding: false,
      //  backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
          elevation: 0.0,
          /*leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                //onPressed: accueil,
              );
            },
          ),*/
          /*leading: new Icon(Icons.arrow_back_ios),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),*/
        ),
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
          ),
          SingleChildScrollView(
            child: new Container(
              color: Colors.transparent,
              child : Form(
                key: _formKey,
               child: new Column(
                 children: <Widget>[
                new Container(
                  padding: EdgeInsets.fromLTRB(20.0, 130.0, 20.0, 10.0),
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
                    padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
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
                            validator: (item){
                              return item.length>5 ? null : "Le mot de passe doit contenir au moins 6 caractères";
                            },
                            //onSubmitted: (String string){},
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
                          onPressed: () =>signInMail(email,password).whenComplete(() =>
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Accueil(),),
                              )
                          ),
                           /* onPressed: (){

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Accueil(),),
                              );
                            },*/
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
                   new Container(
                       padding: EdgeInsets.fromLTRB(35.0, 5.0, 20.0, 10.0),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: Colors.transparent,

                       ),
                       child: new ButtonTheme(
                         minWidth: 190,
                         height:45,
                         child : RaisedButton(
                             onPressed: () => signInGoogle().whenComplete(() =>
                                 Navigator.of(context).push(
                                   MaterialPageRoute(
                                     builder: (context) =>
                                         Accueil(),),
                                 )
                             ),
                             /* onPressed: (){

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Accueil(),),
                              );
                            },*/
                             color: Colors.blueGrey,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(18.0),
                             ),
                             child: new Text(
                               'Se Connecter avec Google',
                               style: TextStyle(
                                   fontSize: 20,
                                   color: Colors.black
                               ),
                             )
                         ),
                       )
                   ),
                  new Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 20.0, 0.0),
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
                              //  recognizer: TapGestureRecognizer()..onTap = handleSignIn,
                                     recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Inscription(),),
                              );

                            }
                            ,

                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold
                                )
                            )
                          ]
                        ),
                      )
                    /*    text: TextSpan(
                            text: "Vous n'avez pas de compte ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16
                            ),
                            children:<TextSpan> [
                              TextSpan(
                                  text: 'Inscrivez-vous.',
                                  recognizer: new TapGestureRecognizer()..onTap = () {
                                    print('TTTTTTTTTTTT');
                                  /*  Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Inscription(),),
                                    );*/
                                  },
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  )
                              )
                            ]
                        ),
                      )*/
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


  Future<bool> signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount != null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(idToken : googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);
      AuthResult result = await auth.signInWithCredential(credential); // to add user to firebase
      FirebaseUser user = await auth.currentUser();
      print(user.uid);
      return Future.value(true);
    }


/*    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken : googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = (await _auth.signInWithCredential(credential)); //AuthResult
    _user = result.user;
    setState(() {
      isSignIn = true;
    });
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Accueil(),),);

   // final FirebaseUser user = await(firebaseAuth.signInWithCredential(credential)).user;
*/
  }

/*  Future<bool> googleSignOut() async {
    FirebaseUser user = await auth.currentUser();
    if(user.providerData[1].providerId == 'google.com'){
    await googleSignIn.disconnect();
  }
    await auth.signOut();
    return Future.value(true);
/*    await auth.signOut().then((onValue){
      googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    }
    );
*/
  }

*/



  Future<bool> signInMail(String email, String password)async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password); // FirebaseUser
        FirebaseUser user = result.user;
        return Future.value(true);
    //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Accueil()));
      }catch(e){
        return showDialog(
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
      }
    }
      /*
      FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: _email, password: _password).then((user) {
          setState(() {

          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  Accueil(),
            )
        );
      }
      ).catchError((onError){
        setState(() {

        });

      });

      */

  }







}