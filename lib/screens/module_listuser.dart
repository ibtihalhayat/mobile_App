import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/chapitres.dart';
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
                padding: EdgeInsets.only(top: 0, left: 30, right: 30),
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
              padding: EdgeInsets.only(top: 245, left: 30, right: 30),
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
          height: 80,
          child: Card(
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            //elevation: 2.0,
            child: ListTile(

              leading: CircleAvatar(
                backgroundColor: getPriorityColor(this.moduleList[position].prioritym),
                child: getPriorityIcon(this.moduleList[position].prioritym),
              ),

              title: Text(this.moduleList[position].nomm, style: TextStyle(fontSize: 30,color: Colors.black),),

              onTap: () {
                setState(() {
                  nomChoisi = this.moduleList[position].nomm;
                  nbChoisi = int.parse(this.moduleList[position].nbchapitres);
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Chapitres(nomCours: nomChoisi,nbChapitres: nbChoisi),),
                );
              },

            ),
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int prioritym) {
    switch (prioritym) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int prioritym) {
    switch (prioritym) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }


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