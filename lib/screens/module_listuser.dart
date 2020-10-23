import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/chapitres.dart';
import 'package:mobile_app/screens/chapitre_list.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:sqflite/sqflite.dart';


class ModuleListUser extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return ModuleListUserState();
  }
}

class ModuleListUserState extends State<ModuleListUser> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Module> moduleList;
  int countm = 0;
  String nomChoisi;
  int nbChoisi;

  @override
  Widget build(BuildContext context) {

    if (moduleList == null) {
      moduleList = List<Module>();
      updateListView();
    }

    return Scaffold(

      body: Stack(
          children:<Widget> [
            new Container(
              decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Bienvenue", style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                        ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('Qu\'est ce que \nvous voulez \napprendre aujourd\'hui?', style: TextStyle(
                        fontSize: 35,
                        height: 1.3,
                        fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 325, left: 10, right: 10),
                child: getModuleListView())
          ]
      ),
    );
  }

  ListView getModuleListView() {

    //TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: countm,
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
                padding: EdgeInsets.only(top: 7),
                  child: Text(this.moduleList[position].nomm, style: TextStyle(fontSize: 37,color: Colors.black),)),

              onTap: () {
                setState(() {
                  nomChoisi = this.moduleList[position].nomm;
                  nbChoisi = int.parse(this.moduleList[position].nbchapitres);
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                  ChapitreListUser(nomCours: nomChoisi, )),
                );
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

      Future<List<Module>> moduleListFuture = databaseHelper.getModuleList();
      moduleListFuture.then((moduleList) {
        setState(() {
          this.moduleList = moduleList;
          this.countm = moduleList.length;
        });
      });
    });
  }
}