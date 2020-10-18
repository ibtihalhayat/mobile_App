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
      appBar: new AppBar(
        title: Text('Modules'),
        backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
        elevation: 0.0,),
      body: getModuleListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetailm(Module('', ''), 'Add Module');
        },

        tooltip: 'Add Module',

        child: Icon(Icons.add),

      ),
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


  // Returns the priority icon


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