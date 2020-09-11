import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:mobile_app/screens/module_detail.dart';
import 'package:sqflite/sqflite.dart';


class ModuleList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return ModuleListState();
  }
}

class ModuleListState extends State<ModuleList> {

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

      body: getModuleListView(),
    );
  }

  ListView getModuleListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: countm,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.moduleList[position].prioritym),
              child: getPriorityIcon(this.moduleList[position].prioritym),
            ),

            title: Text(this.moduleList[position].nomm, style: titleStyle,),
            subtitle: Text(this.moduleList[position].nbchapitres, style: titleStyle,),


            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, moduleList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetailm(this.moduleList[position],'Edit Module');
            },

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

  void _delete(BuildContext context, Module module) async {

    int result = await databaseHelper.deleteModule(module.idm);
    if (result != 0) {
      _showSnackBar(context, 'Module Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetailm(Module module, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ModuleDetail(module, title);
    }));

    if (result == true) {
      updateListView();
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