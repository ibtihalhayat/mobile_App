import 'package:flutter/material.dart';
import 'package:mobile_app/screens/module_list.dart';
import 'package:mobile_app/screens/module_listuser.dart';


class Acc extends StatefulWidget {
  const Acc({Key key}) : super(key: key);

  @override
  _AccState createState() => _AccState();
}

class _AccState extends State<Acc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Mes Cours'),
        backgroundColor: Color(0xFFd7e8ef).withOpacity(1),
        elevation: 0.0,),
      body: ModuleListUser(),
    );
  }

}

