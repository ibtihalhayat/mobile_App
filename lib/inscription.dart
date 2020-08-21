import 'package:flutter/material.dart';

class Inscription extends StatelessWidget{
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
                            child: TextField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Nom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black38)
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
                            child: TextField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Prenom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black38)
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
                            child: TextField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Adresse Mail",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black38)
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
                            child: TextField(
                              textAlign: TextAlign.start,
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
                        padding: EdgeInsets.fromLTRB(210.0, 150.0, 20.0, 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: new ButtonTheme(
                          minWidth: 150,
                          height:45,
                          child : RaisedButton(
                              onPressed: (){
                                print('S\'inscrire');
                              },
                              color: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: new Text(
                                'S\'inscrire',
                                style: TextStyle(
                                    fontSize: 20,
                                  color: Colors.white
                                ),
                              )
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

}