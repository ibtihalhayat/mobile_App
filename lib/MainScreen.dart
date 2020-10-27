import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/auth_choix.dart';



class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // LE CONTENU DE LA PAGE D'ACCUEIL DE L'APPLICATION

        body:new Stack(
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
                    child:Text(
                      '     Cette application met à votre disposition l’ensemble des cours magistraux, ainsi que des Travaux dirigés et des Travaux Pratiques consacrés aux étudiants du 2ème année du cycle d’ingénierie en informatique.\n',
                      style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child:Text(
                      '      Espérant qu’elle vous aidera durant votre cursus scolaire.',
                      style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold

                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 150),
                    padding: EdgeInsets.all(5.0),
                    child:ButtonTheme(
                      minWidth: 190,
                      height:45,
                      child: RaisedButton(
                          onPressed: (){
                           Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AuthChoix(),
                              ),
                            );
                          },
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: new Text(
                            'Commencer',
                            style: TextStyle(
                                fontSize: 20,
                              color: Colors.black
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        )
    );

  }



}










