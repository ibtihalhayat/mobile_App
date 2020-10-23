import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/models/chapitre.dart';
import 'package:mobile_app/chapitres.dart';
import 'package:mobile_app/screens/chapitre_list.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:sqflite/sqflite.dart';


class ChapitreListUser extends StatefulWidget {

  String nomCours;
  ChapitreListUser({this.nomCours});
  @override
  ChapitreListUserState createState() => ChapitreListUserState(nomCours);
}

class ChapitreListUserState extends State<ChapitreListUser> {

  String nomCours;
  ChapitreListUserState(this.nomCours);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Chapitre> chapitreList;
  int countc = 0;
  String nomChoisi;
  int nbChoisi;

  @override
  Widget build(BuildContext context) {

    if (chapitreList == null) {
      chapitreList = List<Chapitre>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 234, 232, 1),
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        backgroundColor: Color.fromRGBO(220, 234, 232, 1),
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 9),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:
                  (context) =>Accueil())),
              child: Icon(
                CupertinoIcons.back,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
          children:<Widget> [
            new Container(
              margin: EdgeInsets.fromLTRB(0, 90, 0, 450),
              //color: Colors.green,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      //colorFilter: new ColorFilter.mode(Colors.blueGrey.withOpacity(1), BlendMode.dstATop),
                      image: new AssetImage("images/logo.png"),
                      fit: BoxFit.fill)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 100, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(nomCours,
                          style: TextStyle(
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.bold,
                              fontSize: 37,
                              color: Color(0xff121212)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                margin: EdgeInsets.fromLTRB(5, 182, 5, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(54)),
                child: getChapitreListView())
          ]
      ),
    );
  }

  ListView getChapitreListView() {

    //TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: countc,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          height: 75,
          child: Card(
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            //elevation: 2.0,
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(right: 0, top: 10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Image.asset(
                      "images/start.png",
                      //color: selected ? Colors.white : Color.fromRGBO(220, 234, 232, 1),
                    ),
                  ),
                ),
              ),
              title: Container(
                  padding: EdgeInsets.only(top: 7
                  ),
                  child: Text('chapitre ${this.chapitreList[position].numchapitre}', style: TextStyle(fontSize: 37,color: Colors.black),)),

              onTap: () {
                setState(() {
                  nomChoisi = this.chapitreList[position].nomcours;
                  nbChoisi = int.parse(this.chapitreList[position].numchapitre);
                });
                /*Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ChapitreListUser(nomCours: nomChoisi),),
                );*/
              },

            ),
          ),
        );
      },
    );
  }

  // Returns the priority color


  // Returns the priority icon



  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Chapitre>> chapitreListFuture = databaseHelper.getChapitreList(nomCours);
      chapitreListFuture.then((chapitreList) {
        setState(() {
          this.chapitreList = chapitreList;
          this.countc = chapitreList.length;
        });
      });
    });
  }
}