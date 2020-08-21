import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authentification extends StatelessWidget {

  String msg;
  Authentification(String msg){
    this.msg = msg;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        backgroundColor: Colors.transparent,
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
      body: new Stack(
        children:<Widget> [
          
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('images/background.png'),
                    fit: BoxFit.cover)
            ),
          ),
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
                 decoration: BoxDecoration(
                     border: Border(
                         bottom: BorderSide(
                             color: Colors.black87
                         )
                     )
                 ),
                 child: TextField(
                   textAlign: TextAlign.center,
                   //onChanged: (String string){},
                  // onSubmitted: (String string){},
                   decoration: new InputDecoration.collapsed(
                       hintText: "adresse mail",
                       border: InputBorder.none,
                       hintStyle: TextStyle(color: Colors.black38)
                   ),
                 ),
               ),
             ],
           ),
         ),
          new Container(
            padding: EdgeInsets.fromLTRB(20.0, 260.0, 20.0, 10.0),
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
                   // onChanged: (String string){},
                    //onSubmitted: (String string){},
                    decoration: new InputDecoration.collapsed(
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
            padding: EdgeInsets.fromLTRB(115.0, 430.0, 20.0, 10.0),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent
            ),
            child: new ButtonTheme(
                  minWidth: 190,
                   height:45,
                child : RaisedButton(
                   onPressed: (){
                     print('vous avez cliqué');},
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
            padding: EdgeInsets.fromLTRB(45.0, 550.0, 20.0, 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent
            ),
            child: RichText(
              text: TextSpan(
                text: "Vous n'avez pas de compte ?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17
                ),
                 children:<TextSpan> [
                   TextSpan(
                     text: "Inscrivez-vous.",
                     style: TextStyle(
                       color: Colors.red,
                       fontSize: 18,
                       fontWeight: FontWeight.bold
                     )
                   )
                 ]
              ),
            )
            /*
            new Text(
                'Vous n\'avez pas de compte? Inscrivez-vous',
                style: new TextStyle(
                  fontSize: 17.5
                ),
            ),
            */
          )
        ],
      )
    );
  }

  /*void accueil(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new MyHomePage();
    }));
  }*/

}