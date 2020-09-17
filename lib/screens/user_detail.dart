import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

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

   // TextStyle textStyle = Theme.of(context).textTheme.title;

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
          appBar: new AppBar(
            backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
            elevation: 0.0,
          ),

          body: Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(image: new DecorationImage(
                    image: new AssetImage("images/background.png"),
                    fit: BoxFit.fill)),
              ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
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

                          style: Theme.of(context).textTheme.title,

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
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(fontSize: 15),
                              controller: nomController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                debugPrint('Something changed in Nom Text Field');
                                updateNom();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Prenom',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              controller: prenomController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                debugPrint('Something changed in Prenom Text Field');
                                updatePrenom();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Third Element
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Adresse mail',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              controller: emailController,
                             // style: textStyle,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                debugPrint('Something changed in Email Text Field');
                                updateEmail();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              maxLength: 15,
                              controller: passwordController,
                          //    style: textStyle,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {
                                debugPrint('Something changed in Password Text Field');
                                updatePassword();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Téléphone',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              controller: telController,
                           //   style: textStyle,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                debugPrint('Something changed in Tel Text Field');
                                updateTel();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Fourth Element
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 55.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'S\'inscrire',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  debugPrint("Vous etes bien inscrit");
                                  _save();
                                });
                                nomController.text='';
                                prenomController.text='';
                                emailController.text='';
                                passwordController.text='';
                                telController.text='';
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
                              color: Colors.red,
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'Supprimer',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  debugPrint("Cet utilisateur va etre supprimé");
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
            ),
      ]
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
      signUpMail();
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

  Future<void> signUpMail() async {

    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Accueil(),),);// FirebaseUser
      } catch (e) {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new SimpleDialog(
                title: Text('Erreur'),
                children: <Widget>[
                  new Text(e.message),
                  new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok')
                  )

                ],
              );
            }
        );
      }
    }
  }

}