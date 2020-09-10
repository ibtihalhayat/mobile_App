import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatefulWidget {

  final String appBarTitle;
  final User user;

  UserDetail(this. user, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return UserDetailState(this.user, this.appBarTitle);
  }
}

class UserDetailState extends State<UserDetail> {

  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  User user;

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telController = TextEditingController();

  UserDetailState(this.user, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    nomController.text = user.nom;
    prenomController.text = user.prenom;
    emailController.text = user.email;
    passwordController.text = user.password;
    telController.text = user.tel;

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

                      value: getPriorityAsString(user.priority),

                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('User selected $valueSelectedByUser');
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      }
                  ),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nomController,
                    style: textStyle,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      debugPrint('Something changed in Nom Text Field');
                      updateNom();
                    },
                    decoration: InputDecoration(
                        labelText: 'Nom',
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
                    controller: prenomController,
                    style: textStyle,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      debugPrint('Something changed in Prenom Text Field');
                      updatePrenom();
                    },
                    decoration: InputDecoration(
                        labelText: 'Prenom',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: emailController,
                    style: textStyle,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      debugPrint('Something changed in Email Text Field');
                      updateEmail();
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
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
                    controller: passwordController,
                    style: textStyle,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      debugPrint('Something changed in Password Text Field');
                      updatePassword();
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
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
                    controller: telController,
                    style: textStyle,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      debugPrint('Something changed in Tel Text Field');
                      updateTel();
                    },
                    decoration: InputDecoration(
                        labelText: 'Tel',
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
                              debugPrint("Save button clicked");
                              _save();
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Accueil(),),
                            );
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
        user.priority = 1;
        break;
      case 'Low':
        user.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];  // 'High'
        break;
      case 2:
        priority = _priorities[1];  // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateNom(){
    user.nom = nomController.text;
  }

  void updatePrenom(){
    user.prenom = prenomController.text;
  }

  // Update the description of Note object
  void updateEmail() {
    user.email = emailController.text;
  }

  void updatePassword() {
    user.password = passwordController.text;
  }

  void updateTel() {
    user.tel = telController.text;
  }

  // Save data to database
  void _save() async {

    //moveToLastScreen();

    user.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (user.id != null) {  // Case 1: Update operation
      result = await helper.updateUser(user);
    } else { // Case 2: Insert Operation
      result = await helper.insertUser(user);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (user.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteUser(user.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
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