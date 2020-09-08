/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/Accueil.dart';
import 'package:mobile_app/bloc/module_bloc.dart';
import 'package:mobile_app/db/database_provider_module.dart';
import 'package:mobile_app/events/add_module.dart';
import 'package:mobile_app/events/update_module.dart';
import 'package:mobile_app/models/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleForm extends StatefulWidget {
  final Module module;
  final int moduleIndex;

  ModuleForm({this.module, this.moduleIndex});

  @override
  State<StatefulWidget> createState() {
    return ModuleFormState();
  }
}

class ModuleFormState extends State<ModuleForm> {
  String _nom;
  String _nbchapitres;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget _buildNom() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children:<Widget> [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            // padding: EdgeInsets.all(5.0),
            child: TextFormField(
              initialValue: _nom,
              decoration: InputDecoration(labelText: 'Nom'),
              maxLength: 15,
              style: TextStyle(fontSize: 15),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Nom is Required';
                }

                return null;
              },
              onSaved: (String value) {
                _nom = value;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNbchapitres() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children:<Widget> [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            //padding: EdgeInsets.all(0.0),
            child: TextFormField(
              initialValue: _nbchapitres,
              decoration: InputDecoration(labelText: 'NbChapitres'),
              maxLength: 15,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Prenom is Required';
                }

                return null;
              },
              onSaved: (String value) {
                _nbchapitres = value;
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.module != null) {
      _nom = widget.module.nom;
      _nbchapitres = widget.module.nbchapitres;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            SingleChildScrollView(
              child: new Container(
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: new Column(
                    children: <Widget>[
                      _buildNom(),
                      _buildNbchapitres(),
                      widget.module == null
                          ? new Container(
                          padding: EdgeInsets.fromLTRB(190.0, 40.0, 20.0, 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent
                          ),
                          child: new ButtonTheme(
                            minWidth: 150,
                            height: 45,
                            child: RaisedButton(
                                onPressed: () {
                                  BlocProvider<ModuleBloc>(
                                    create: (context) => ModuleBloc(),
                                  );

                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  _formKey.currentState.save();

                                  Module module = Module(
                                    nom: _nom,
                                    nbchapitres: _nbchapitres,
                                  );

                                  DatabaseProvider.db.insert(module).then(
                                        (storedModule) =>
                                        BlocProvider.of<ModuleBloc>(context).add(
                                          AddModule(storedModule),
                                        ),
                                  );

                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Accueil(),),);

                                },
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: new Text(
                                  'Valider',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                  ),
                                )
                            ),
                          )
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 16),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                print("form");
                                return;
                              }

                              _formKey.currentState.save();

                              Module module = Module(
                                nom: _nom,
                                nbchapitres: _nbchapitres,
                              );

                              DatabaseProvider.db.update(widget.module).then(
                                    (storedModule) =>
                                    BlocProvider.of<ModuleBloc>(context).add(
                                      UpdateModule(widget.moduleIndex, module),
                                    ),
                              );

                              Navigator.pop(context);
                            },
                          ),
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
            ),
          ]
      ),
    );
  }



}*/
