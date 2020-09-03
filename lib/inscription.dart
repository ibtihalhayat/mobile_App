/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/outils/database.dart';
import 'package:mobile_app/bloc/user_bloc.dart';
import 'package:mobile_app/db/database_provider.dart';
import 'package:mobile_app/events/add_user.dart';

class Inscription extends StatefulWidget{
  final User user;
  final int userIndex;

  Inscription({this.user, this.userIndex});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  String _email , _password, _nom , _prenom ;
  int _tel;
  FirebaseAuth auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();

//  DatabaseHelper databaseHelper = DatabaseHelper();
//  List<User> userList;
//  int count = 0 ;

  @override
  Widget build(BuildContext context) {
 /*   if(userList == null){
      userList = List<User>();
      updateListView();
    }*/


    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("images/background.png"), fit: BoxFit.fill)),
          ),
          SingleChildScrollView(
            child: new Container(
              color: Colors.transparent,
              child : Form(
                 key: _formKey,
               child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              onSaved: (item){
                                setState((){
                                  _nom = item;
                                });
                              },
                              validator: (item){
                                return item!=null ? null : "Veuillez remplir ce champ";
                              },
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Nom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              onSaved: (item){
                                setState((){
                                  _prenom = item;
                                });
                              },
                              validator: (item){
                                return item!=null ? null : "Veuillez remplir ce champ";
                              },
                              decoration: new InputDecoration(
                                  hintText: "Prenom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (item){
                                setState((){
                                  _email = item;
                                });
                              },
                              validator: (item){
                                return item.contains("@") ? null : "Entrez une adresse mail valide";
                              },
                              /*onChanged: (String string){},
                              // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Adresse Mail",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black87
                                    )
                                )
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              obscureText: true,
                              onSaved: (item){
                                setState((){
                                  _password = item;
                                });
                              },
                              validator: (item){
                                return item.length>5 ? null : "Le mot de passe doit contenir au moins 6 caractères";
                              },
                              // onChanged: (String string){},
                              //onSubmitted: (String string){},
                              decoration: new InputDecoration(
                                  hintText: "mot de passe",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent
                      ),
                      child: Column(
                        children:<Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                              // decoration: new InputDecoration(hintText: "adresse mail"),
                              textAlign: TextAlign.start,
                              onSaved: (item){
                                setState((){
                                  _tel = int.parse(item);
                                });
                              },
                              validator: (item){
                                return item!=null ? null : "Veuillez remplir ce champ";
                              },
                              /*onChanged: (String string){},
                      // onSubmitted: (String string){},*/
                              decoration: new InputDecoration(
                                  hintText: "Nom",
                                  //  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                        padding: EdgeInsets.fromLTRB(190.0, 150.0, 20.0, 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.transparent
                        ),
                        child: new ButtonTheme(
                          minWidth: 150,
                          height:45,
                          child : RaisedButton(
                              onPressed: () {
                           /*     var newDBUser = User(nom: nom, prenom: prenom, email: email, password: password, tel: tel);
                                DBProvider.db.newUser(newDBUser);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Accueil(),),
                                );*/
                               if(signUpMail()==true){Navigator.of(context).pushReplacement(
                                 MaterialPageRoute(
                                    builder: (context) =>
                                          Accueil(),),
                                              );}
                              }
                      /*        =>signUpMail().whenComplete(() =>
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Accueil(),),
                                  )
                              )*/,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: new Text(
                                'S\'inscrire',
                                style: TextStyle(
                                    fontSize: 20,
                                  color: Colors.black
                                ),
                              )
                          ),
                        )
                    )
                  ]
              ),
            ),
            ),


          )
        ],
      ),

    );
  }

/*  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<User>> userListFuture = databaseHelper.getUserList();
    });
  }*/

  Future<void> signUpMail()async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password); // FirebaseUser
      } catch (e) {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new SimpleDialog(
                title: Text('Erreur'),
                children:<Widget> [
                  new Text(e.message),
                  new FlatButton(
                      onPressed: (){
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



/*  Future<bool> signUpMail(String email, String password)async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password); // FirebaseUser
        FirebaseUser user = result.user;
        return Future.value(true);
        //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Accueil()));
      }catch(e){
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new SimpleDialog(
                title: Text('Erreur'),
                children:<Widget> [
                  new Text(e.message),
                  new FlatButton(
                      onPressed: (){
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


  }*/




}*/



import 'package:mobile_app/bloc/user_bloc.dart';
import 'package:mobile_app/db/database_provider.dart';
import 'package:mobile_app/events/add_user.dart';
import 'package:mobile_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_list.dart';

class UserForm extends StatefulWidget {
  final User user;
  final int userIndex;

  UserForm({this.user, this.userIndex});

  @override
  State<StatefulWidget> createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  String _nom;
  String _prenom;
  String _email;
  String _password;
  String _tel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget _buildNom() {
    return TextFormField(
      initialValue: _nom,
      decoration: InputDecoration(labelText: 'Nom'),
      maxLength: 15,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _nom = value;
      },
    );
  }

  Widget _buildPrenom() {
    return TextFormField(
      initialValue: _prenom,
      decoration: InputDecoration(labelText: 'Prenom'),
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        int calories = int.tryParse(value);


        return null;
      },
      onSaved: (String value) {
        _prenom = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: _email,
      decoration: InputDecoration(labelText: 'Email'),
      maxLength: 15,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      initialValue: _password,
      decoration: InputDecoration(labelText: 'Password'),
      maxLength: 15,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildTel() {
    return TextFormField(
      initialValue: _tel.toString(),
  //    keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Tel'),
      maxLength: 15,
      style: TextStyle(fontSize: 18),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Tel is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _tel = value ;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nom = widget.user.nom;
      _prenom = widget.user.prenom;
      _email = widget.user.email;
      _password = widget.user.password;
      _tel = widget.user.tel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNom(),
              _buildPrenom(),
              _buildEmail(),
              _buildPassword(),
              _buildTel(),
              SizedBox(height: 16),
              SizedBox(height: 20),
              widget.user == null
                  ? RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  User user = User(
                      nom: _nom,
                      prenom: _prenom,
                      email: _email,
                      password: _password,
                      tel: _tel);

                  DatabaseProvider.db.insert(user).then(
                        (storedUser) => BlocProvider.of<UserBloc>(context).add(
                      AddUser(storedUser),
                    ),
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserList(),),
                  );
                },
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}