import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/models/chapitre.dart';
import 'package:mobile_app/chapitres.dart';
import 'package:mobile_app/pdf_page.dart';
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
  int donee;
  int avancement=0;
  MaterialColor couleur=Colors.red;
  DatabaseHelper helper = DatabaseHelper();

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
                        //Affichage du nom de cours
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
        donee = int.parse(this.chapitreList[position].done);
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 75,
          child: Card(
            color: Colors.white,
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
                  color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(54)),
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
              trailing: IconButton(
                icon: Icon(Icons.done),
                color: donee ==0 ? couleur : Colors.green, // choix de couleur(si chapitre n'est pas fait couleur = rouge, sinon couleur = vert
                onPressed: (){
                  helper.updateChapitre(nomCours, this.chapitreList[position].numchapitre);
                  helper.getChapitreMapList(nomCours);
                  donee = int.parse(this.chapitreList[position].done);
                  avancement = int.parse(this.chapitreList[position].numchapitre);
                  print('etat est ${donee}'); // affichage de l'etat du chapitre
                },
              ),
              title: Container(
                  padding: EdgeInsets.only(top: 7
                  ),
                  // Affichage de la liste des chapitres
                  child: Text('chapitre ${this.chapitreList[position].numchapitre}', style: TextStyle(fontSize: 37,color: Colors.black),)),

              onTap: () {
                setState(() {
                  nomChoisi = this.chapitreList[position].nomcours;
                  nbChoisi = int.parse(this.chapitreList[position].numchapitre);
                  donee = int.parse(this.chapitreList[position].done);
                });
                if(nbChoisi == 1) { // toujours user a la possibilité de lire le premier chapitre
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            Pdfviewerpage(nomCourss: nomChoisi,
                              numChapitre: nbChoisi,)),
                  );
                }
                if(nbChoisi == avancement + 1 ){ // c possible de lire juste le chapitre qui suit l'avancement
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            Pdfviewerpage(nomCourss: nomChoisi,
                              numChapitre: nbChoisi,)),
                  );
                }
              },

            ),
          ),
        );
      },
    );
  }


  // mise a jour de la liste affichée des chapitres
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Chapitre>> chapitreListFuture = databaseHelper.getChapitreList(nomCours);
      chapitreListFuture.then((chapitreList) {
        setState(() {
          this.chapitreList = chapitreList; // liste des chapitres
          this.countc = chapitreList.length; // le nombre de chapitres
        });
      });
    });
  }
}