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
        backgroundColor: Color.fromRGBO(220, 234, 232, 1),
        elevation: 0.0,),
      body: ModuleListUser(),
    );
  }

}

