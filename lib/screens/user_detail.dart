import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/AccueilProf.dart';
import 'package:mobile_app/acc.dart';
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


  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  User user;

  // Controlleurs qui vont contenir les informations saisies
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telController = TextEditingController();

  UserDetailState(this.user, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    // TextStyle textStyle = Theme.of(context).textTheme.title;

    // Affecter les informations saisies au user créé
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
            backgroundColor: Color.fromRGBO(220, 234, 232, 1),
            elevation: 0.0,
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    if(appBarTitle == 'Edit User'){
                      Navigator.pop(context);
                    }else {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => Accueil()));
                    }
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
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[

                        //LES CHAMPS DU FORMULAIRE D'INSCRIPTION

                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child: Column(
                            children:<Widget> [

                              //LE CHAMP " NOM "

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
                                    updateNom();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //LE CHAMP " PRENOM "

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
                                    labelText: 'Prenom',
                                    hintStyle: TextStyle(color: Colors.black),
                                  ),
                                  controller: prenomController,
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    updatePrenom();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //LE CHAMP " ADRESSE MAIL "

                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                                    updateEmail();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //LE CHAMP " MDP " QUI NE DOIT PAS DEPASSER 15 CARACTERES

                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                                  validator: (value){
                                    return value.length < 6 ? 'Le mot de passe doit etre compris entre 6 et 15 caractères' : null;
                                  },
                                  maxLength: 15,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (value) {
                                    updatePassword();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //LE CHAMP " NUM DE TELEPHONE "

                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
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
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    updateTel();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //LE BOUTTON " S'INSCRIRE "

                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 55.0, 20.0, 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child:Container(
                                  padding: EdgeInsets.only(left: 150),
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
                                              AccueilProf(),),
                                      );
                                    },
                                  ),
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

  // FONCTION DE RETOUR A L INTERFACE PRECEDENTE
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }


  // FONCTION DE MISE A JOUR DU NOM
  void updateNom(){
    user.nom = nomController.text;
  }

  // FONCTION DE MISE A JOUR DU PRENOM
  void updatePrenom(){
    user.prenom = prenomController.text;
  }

  // FONCTION DE MISE A JOUR DE L'ADRESSE MAIL
  void updateEmail() {
    user.email = emailController.text;
  }

  // FONCTION DE MISE A JOUR DU MDP
  void updatePassword() {
    user.password = passwordController.text;
  }

  // FONCTION DE MISE A JOUR DU NUM DE TELEPHONE
  void updateTel() {
    user.tel = telController.text;
  }

  // // FONCTION D'ENREGISTREMENT DE L'ETUDIANT
  void _save() async {

    int result;
    if (user.id != null) {  // Case 1: MAJ DE L'ETUDIANT
      result = await helper.updateUser(user);
    } else { // Case 2: INSERTION DE L'ETUDIANT
      result = await helper.insertUser(user);
      signUpMail();
    }

    if (result != 0) {  // Succes
      _showAlertDialog('Status', 'vous etes inscrit avec succès');
    } else {  // ERREUR
      _showAlertDialog('Status', 'Erreur d\'inscription');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 2: ESSAI DE SUPPRESION DE L'EUDIANT RECEMMENT AJOUTE
    if (user.id == null) {
      _showAlertDialog('Status', 'Aucun étudiant supprimé');
      return;
    }

    // Case 2: ESSAI DE SUPPRESION D'UN ETUDIANT EXISTANT
    int result = await helper.deleteUser(user.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Etudiant supprimé avec succès');
    } else {
      _showAlertDialog('Status', 'Erreur de suppression de l\'étudiant');
    }
  }

  //FONCTION QUI AFFICHE LES MESSAGES D'ERREUR
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

  //FONCTION QUI AJOUTE L'ETUDIANT INSCRIT DANS LA BASE DE DONNEES DE L'APPLIVATION
  Future<void> signUpMail() async {

    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try { // AJOUT DE L 'ETUDIANT PAR SON ADRESSE MAIL ET MOT DE PASSE INSERES
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Accueil(),),); // FirebaseUser
        } catch (e) { // AU CAS D'ERREUR
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