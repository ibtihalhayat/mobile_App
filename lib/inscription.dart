import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';

class Inscription extends StatefulWidget{

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String _email , _password , _nom , _prenom ;

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
        elevation: 0.0,
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
                      padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              onSaved: (item){
                                setState((){
                                  _nom = item;
                                });
                              },
                              validator: (item){
                                return item==null ? "Veuillez remplir ce champ" : null;
                              },
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Nom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              onSaved: (item){
                                setState((){
                                  _prenom = item;
                                });
                              },
                              validator: (item){
                                return item!=null ? null : "Veuillez remplir ce champ";
                              },
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Prenom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (item){
                                setState((){
                                  _email = item;
                                });
                              },
                              validator: (item){
                                return item.contains("@") ? null : "Entrez une adresse mail valide";
                              },
                              /*onChanged: (String string){},
                              // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Adresse Mail",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
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
                                  _password = item;
                                });
                              },
                              validator: (item){
                                return item.length>5 ? null : "Le mot de passe doit contenir au moins 6 caractères";
                              },
                              // onChanged: (String string){},
                              //onSubmitted: (String string){},
                              decoration: new InputDecoration(
                                  hintText: "mot de passe",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                        padding: EdgeInsets.fromLTRB(190.0, 150.0, 20.0, 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: new ButtonTheme(
                          minWidth: 150,
                          height:45,
                          child : RaisedButton(
                              onPressed: signUp,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: new Text(
                                'S\'inscrire',
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


          )
        ],
      ),

    );
  }

  Future<void> signUp()async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email, password: _password); // FirebaseUser
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Accueil()));
      } catch (e) {
        print(e.message);
      }
    }
  }

 /* String champVide(String string) {

  }*/

}