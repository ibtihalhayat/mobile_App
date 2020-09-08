import 'package:flutter/material.dart';
import 'package:mobile_app/db_helper.dart';
import 'package:mobile_app/student_model.dart';
import 'package:mobile_app/module_model.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>> students;
  String _studentName;
  String _studentPrenom;
  String _studentEmail;
  String _studentPassword;
  bool isUpdate = false;
  int studentIdForUpdate;
  DBHelper dbHelper;
  final _studentNameController = TextEditingController();
  final _studentPrenomController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _studentPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshStudentList();
  }

  refreshStudentList() {
    setState(() {
      students = dbHelper.getStudents();
    });
  }

  Widget _buildName(){
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Student Name';
                }
                if (value.trim() == "")
                  return "Only Space is Not Valid!!!";
                return null;
              },
              onSaved: (value) {
                _studentName = value;
              },
              controller: _studentNameController,
              decoration: InputDecoration(
                  labelText: "Student Name",
                  ),
              maxLength: 15,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.name,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrenom(){
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Student Prenom';
                }
                if (value.trim() == "")
                  return "Only Space is Not Valid!!!";
                return null;
              },
              onSaved: (value) {
                _studentPrenom = value;
              },
              controller: _studentPrenomController,
              decoration: InputDecoration(
                labelText: "Student Prenom",
              ),
              maxLength: 15,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.name,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail(){
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Student Email';
                }
                if (value.trim() == "")
                  return "Only Space is Not Valid!!!";
                return null;
              },
              onSaved: (value) {
                _studentEmail = value;
              },
              controller: _studentEmailController,
                decoration: InputDecoration(
                  labelText: "Student Email",
                ),
                style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassword(){
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Student Password';
                }
                if (value.trim() == "")
                  return "Only Space is Not Valid!!!";
                return null;
              },
              onSaved: (value) {
                _studentPassword = value;
              },
              controller: _studentPasswordController,
              decoration: InputDecoration(
                labelText: "Student Password",
              ),
              maxLength: 15,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD in Flutter'),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(
                image: new AssetImage("images/background.png"),
                fit: BoxFit.fill)),
          ),
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                _buildName(),
                _buildPrenom(),
                _buildEmail(),
                _buildPassword(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  (isUpdate ? 'MODIFIER' : 'AJOUTER'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper
                          .update(Student(studentIdForUpdate, _studentName, _studentPrenom, _studentEmail, _studentPassword))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper.add(Student(null, _studentName, _studentPrenom, _studentEmail, _studentPassword));
                    }
                  }
                  _studentNameController.text = '';
                  _studentPrenomController.text = '';
                  _studentEmailController.text = '';
                  _studentPasswordController.text = '';
                  refreshStudentList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  (isUpdate ? 'ANNULER MODIFICATION' : 'EFFACER'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _studentNameController.text = '';
                  _studentPrenomController.text = '';
                  _studentEmailController.text = '';
                  _studentPasswordController.text = '';
                  setState(() {
                    isUpdate = false;
                    studentIdForUpdate = null;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }


  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Nom'),
            ),
            DataColumn(
              label: Text('Prenom'),
            ),
            DataColumn(
              label: Text('Email'),
            ),
            DataColumn(
              label: Text('Pass'),
            ),
            DataColumn(
              label: Text('Supprimer'),
            )
          ],
          rows: students
              .map(
                (student) => DataRow(
              cells: [
                DataCell(
                  Text(student.name),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentNameController.text = student.name;
                  },
                ),
                DataCell(
                  Text(student.prenom),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentPrenomController.text = student.prenom;
                  },
                ),
                DataCell(
                  Text(student.email),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentEmailController.text = student.email;
                  },
                ),
                DataCell(
                  Text(student.password),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentPasswordController.text = student.password;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(student.id);
                      refreshStudentList();
                    },
                  ),
                )
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}












class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final GlobalKey<FormState> _formStateKeym = GlobalKey<FormState>();
  Future<List<Module>> modules;
  String _moduleNamem;
  bool isUpdate = false;
  int moduleIdForUpdate;
  DBHelper dbHelper;
  final _moduleNamemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshModuleList();
  }

  refreshModuleList() {
    setState(() {
      modules = dbHelper.getModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD in Flutter'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKeym,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Module Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _moduleNamem = value;
                    },
                    controller: _moduleNamemController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.purple,
                                width: 2,
                                style: BorderStyle.solid)),
                        // hintText: "Student Name",
                        labelText: "Module Name",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.purple,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.purple,
                child: Text(
                  (isUpdate ? 'UPDATE' : 'ADD'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKeym.currentState.validate()) {
                      _formStateKeym.currentState.save();
                      dbHelper
                          .updatem(Module(moduleIdForUpdate, _moduleNamem))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKeym.currentState.validate()) {
                      _formStateKeym.currentState.save();
                      dbHelper.addm(Module(null, _moduleNamem));
                    }
                  }
                  _moduleNamemController.text = '';
                  refreshModuleList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _moduleNamemController.text = '';
                  setState(() {
                    isUpdate = false;
                    moduleIdForUpdate = null;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: modules,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateListm(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateListm(List<Module> modules) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: modules
              .map(
                (module) => DataRow(
              cells: [
                DataCell(
                  Text(module.namem),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      moduleIdForUpdate = module.id;
                    });
                    _moduleNamemController.text = module.namem;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.deletem(module.id);
                      refreshModuleList();
                    },
                  ),
                )
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}