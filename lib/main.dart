import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      '     Cette application met à votre disposition l’ensemble des cours magistraux, ainsi que des Travaux dirigés et des Travaux Pratiques consacrés aux étudiants du 2ème année du cycle d’ingénierie en informatique.',
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
                          onPressed: authentification,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: new Text(
                            'Commencer',
                            style: TextStyle(
                                fontSize: 20
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


  void authentification(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new Auth('c le message');
    }));
  }

}
