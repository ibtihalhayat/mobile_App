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
          leading: new Icon(Icons.arrow_back_ios),
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
           padding: EdgeInsets.fromLTRB(20.0, 200.0, 20.0, 10.0),
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
                   onChanged: (String string){},
                   onSubmitted: (String string){},
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
            padding: EdgeInsets.fromLTRB(20.0, 290.0, 20.0, 10.0),
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
                    onChanged: (String string){},
                    onSubmitted: (String string){},
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
            padding: EdgeInsets.fromLTRB(115.0, 450.0, 20.0, 10.0),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent
            ),
            child: new ButtonTheme(
                  minWidth: 190,
                   height:45,
                child : RaisedButton(
                onPressed: (){print('OKKK');},
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
          )
        ],
      )
    );
  }
}