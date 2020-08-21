//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'Accueil.dart';

class Auth extends StatelessWidget {

  String message;
  Auth(String message){
    this.message = message;
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
              child: new Column(
                children: <Widget>[
               new Container(
                padding: EdgeInsets.fromLTRB(20.0, 170.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.transparent
                 ),
                child: Column(
                 children:<Widget> [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      // decoration: new InputDecoration(hintText: "adresse mail"),
                      textAlign: TextAlign.center,
                      /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                      decoration: new InputDecoration(
                          hintText: "adresse mail",
                          //  border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black38)
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
                          child: TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            // onChanged: (String string){},
                            //onSubmitted: (String string){},
                            decoration: new InputDecoration(
                                hintText: "mot de passe",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.black38)
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
                            onPressed: (){print('OKKKK');},
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: new Text(
                              'Se Connecter',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            )
                        ),
                      )
                  ),
                  new Container(
                      padding: EdgeInsets.fromLTRB(15.0, 150.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: RichText(
                        text: TextSpan(
                            text: "Vous n'avez pas de compte ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16
                            ),
                            children:<TextSpan> [
                              TextSpan(
                                  text: "Inscrivez-vous.",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  )
                              )
                            ]
                        ),
                      )
                  )
            ]
          ),
    ),


          )
        ],
      ),
      
    );
  }

/*void accueil(){
  /*  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new Accueil('msg');
    }));*/
  Navigator.push(context , MaterialPageRoute(builder: (context) =>Accueil('vlll')),
  );
  }*/


}