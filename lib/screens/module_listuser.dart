import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/sommaire.dart';
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
          Container(child: getModuleListView())
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
          height: 70,
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

              title: Text(this.moduleList[position].nomm, style: TextStyle(fontSize: 26,color: Colors.black),),

              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Sommaire(),),
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