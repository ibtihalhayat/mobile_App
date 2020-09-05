import 'package:mobile_app/db/database_provider.dart';
import 'package:mobile_app/events/delete_user.dart';
import 'package:mobile_app/events/set_users.dart';
import 'package:mobile_app/inscription.dart';
import 'package:mobile_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc.dart';

class Acc extends StatefulWidget {
  const Acc({Key key}) : super(key: key);

  @override
  _AccState createState() => _AccState();
}

class _AccState extends State<Acc> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('c\'est l\'accueil'),
    );
  }

}

