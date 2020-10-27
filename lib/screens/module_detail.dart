import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/AccueilProf.dart';
import 'package:mobile_app/models/chapitre.dart';
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


  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Module module;
  Chapitre chapitre;

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
          appBar: new AppBar(
            backgroundColor: Color.fromRGBO(220, 234, 232, 1),
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                );
              },
            ),
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
                     child: ListView(
                         children: <Widget>[

                           //LES CHAMPS DU FORMULAIRE D'AJOUT D'UN MODULE

                           Container(
                             padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10.0),
                                 color: Colors.transparent
                             ),
                             child: Column(
                               children:<Widget> [

                                 //LE CHAMP " NOM DU MODULE"

                                 Container(
                                   margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                   child: TextFormField(
                                     decoration: InputDecoration(
                                       labelText: 'Nom',
                                       hintStyle: TextStyle(color: Colors.black),
                                     ),
                                     style: TextStyle(fontSize: 15),
                                     controller: nommController,
                                     keyboardType: TextInputType.name,
                                     onChanged: (value) {
                                       updateNomm();
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           //LE CHAMP " NOMBRE DES CHAPITRES"
                           Container(
                             padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                                       labelText: 'Nombre de chapitres',
                                       hintStyle: TextStyle(color: Colors.black),
                                     ),
                                     controller: nbchapitresController,
                                     keyboardType: TextInputType.number,
                                     onChanged: (value) {
                                       updateNbchapitres();
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),

                           // BOUTTON AJOUTER

                           Row(
                             children: <Widget> [
                                 Container(
                                     padding: EdgeInsets.fromLTRB(10.0, 55.0, 0.0, 10.0),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10.0),
                                         color: Colors.transparent
                                     ),
                                     child:Container(
                                       padding: EdgeInsets.only(left: 0, right: 11),
                                       child: SizedBox(
                                         width: 170,
                                         child: RaisedButton(
                                           color: Colors.red,
                                           textColor: Colors.black,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(18.0),
                                           ),
                                           child: Text(
                                             'Ajouter',
                                             textScaleFactor: 1.5,
                                           ),
                                           onPressed: () {
                                             setState(() {
                                               _save();
                                             });
                                             nommController.text='';
                                             nbchapitresController.text='';
                                             Navigator.of(context).push(
                                               MaterialPageRoute(
                                                 builder: (context) =>
                                                     AccueilProf(),),
                                             );
                                           },
                                         ),
                                       ),
                                     ),
                               ),

                               // BOUTTON SUPPRIMER
                               Container(
                                 padding: EdgeInsets.fromLTRB(10.0, 55.0, 20.0, 10.0),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10.0),
                                     color: Colors.transparent
                                 ),
                                 child:Container(
                                   padding: EdgeInsets.only(left: 0, right: 0),
                                   child: SizedBox(
                                     width: 170,
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
                                           _delete();
                                         });
                                         nommController.text='';
                                         nbchapitresController.text='';
                                         Navigator.of(context).push(
                                           MaterialPageRoute(
                                             builder: (context) =>
                                                 AccueilProf(),),
                                         );
                                       },
                                     ),
                                   ),
                                 ),
                               ),
                              ]
                           )
                         ]
                     ),
                 ),
                ),
              ]
          ) ,
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database


  // Convert int priority to String priority and display it to user in DropDown


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

   // await helper.updateChapitre('Java', '1');
  //  await helper.getChapitreMapList('Java');
    int result;
    if (module.idm != null) {  // Case 1: Update operation
      result = await helper.updateModule(module);
    } else { // Case 2: Insert Operation
      result = await helper.insertModule(module);
      for(int j=1 ; j <= int.parse(module.nbchapitres) ; j++)
        {
          await helper.insertChapitre(Chapitre(module.nomm , j.toString() , '0'));
          print('chapppppppppppppppppppppp ${j} est ajoutéééééééééééééééé');
          }
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