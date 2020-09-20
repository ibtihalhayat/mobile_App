import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/models/module.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class ModuleDetail extends StatefulWidget {

  final String appBarTitle;
  final Module module;

  ModuleDetail(this. module, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return ModuleDetailState(this.module, this.appBarTitle);
  }
}

class ModuleDetailState extends State<ModuleDetail> {

  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Module module;

  TextEditingController nommController = TextEditingController();
  TextEditingController nbchapitresController = TextEditingController();

  ModuleDetailState(this.module, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    nommController.text = module.nomm;
    nbchapitresController.text = module.nbchapitres;

    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                // First element
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String> (
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),

                      style: textStyle,

                      value: getPriorityAsString(module.prioritym),

                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('Module selected $valueSelectedByUser');
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      }
                  ),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nommController,
                    style: textStyle,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      debugPrint('Something changed in Nom Text Field');
                      updateNomm();
                    },
                    decoration: InputDecoration(
                        labelText: 'Nomm',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nbchapitresController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      debugPrint('Something changed in Nbchapitres Text Field');
                      updateNbchapitres();
                    },
                    decoration: InputDecoration(
                        labelText: 'Nbchapitres',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),

                          onPressed: () {
                            setState(() {
                              debugPrint("Le module a été bien ajouté");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        module.prioritym = 1;
        break;
      case 'Low':
        module.prioritym = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String prioritym;
    switch (value) {
      case 1:
        prioritym = _priorities[0];  // 'High'
        break;
      case 2:
        prioritym = _priorities[1];  // 'Low'
        break;
    }
    return prioritym;
  }

  // Update the title of Note object
  void updateNomm(){
    module.nomm = nommController.text;
  }

  void updateNbchapitres(){
    module.nbchapitres = nbchapitresController.text;
  }

  // Save data to database
  void _save() async {

    //moveToLastScreen();

    module.datem = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (module.idm != null) {  // Case 1: Update operation
      result = await helper.updateModule(module);
    } else { // Case 2: Insert Operation
      result = await helper.insertModule(module);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Module Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Module');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (module.idm == null) {
      _showAlertDialog('Status', 'No Module was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteModule(module.idm);
    if (result != 0) {
      _showAlertDialog('Status', 'Module Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Module');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}