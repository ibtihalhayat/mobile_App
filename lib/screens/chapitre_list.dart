import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/chapitre.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/chapitres.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';


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

      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: false,
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(220, 234, 232, 1),
                  expandedHeight: 175,
                  automaticallyImplyLeading: false,
                  title: Container(
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
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          CupertinoIcons.back,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Image.asset("images/logo.png",
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(54)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(nomCours,
                          style: TextStyle(
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                              color: Color(0xff121212)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: getChapitreListView(),
                       /* for(int i=1; i<=nbChapitres; i++)
                          CustomTile(
                              title: "chapitre $i",
                              num: i,
                              nomCoursChoisi: nomCours,
                              fait: false),
*/
                    ),
                    SizedBox(
                      height: 110,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      );
/*            Container(
                padding: EdgeInsets.only(top: 325, left: 10, right: 10),
                child: getChapitreListView())
 */

  }

  ListView getChapitreListView() {

    //TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
     // itemCount: countc,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          //height: 75,
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
                //height: 50,
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
                  padding: EdgeInsets.only(top: 7),
                  child: Text('chapitre ${this.chapitreList[position].numchapitre} ', style: TextStyle(fontSize: 37,color: Colors.black),)

              ),


              onTap: () {
                setState(() {
                  nomChoisi = this.chapitreList[position].nomcours;
                  nbChoisi = int.parse(this.chapitreList[position].numchapitre);
                });
               /* Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Chapitres(nomCours: nomChoisi,nbChapitres: nbChoisi),),
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