import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/AccueilProf.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/utils/database_helper.dart';
import 'package:mobile_app/screens/user_detail.dart';
import 'package:sqflite/sqflite.dart';


class UserList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return UserListState();
  }
}

class UserListState extends State<UserList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<User> userList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (userList == null) {
      userList = List<User>();
      updateListView();
    }

    return Scaffold(

      appBar: new AppBar(
        title: Text('Etudiants'),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
      ),

      body: getUserListView(),

    );
  }

  ListView getUserListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            title: Text(this.userList[position].email, style: titleStyle,),
            subtitle: Text(this.userList[position].password, style: titleStyle,),


            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, userList[position]);
              },
            ),


            onTap: () { // Si on clique sur la liste les infos concernant ce user choisi seront affichés
              navigateToDetail(this.userList[position],'Edit User');
            },

          ),
        );
      },
    );
  }


// Fait appel à la fonction de suppression dans database_helper
  void _delete(BuildContext context, User user) async {

    int result = await databaseHelper.deleteUser(user.id);
    if (result != 0) {
      _showSnackBar(context, 'Etudiant supprimé avec succès');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(User user, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserDetail(user, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  // Mettre à jour la liste des étudiants
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<User>> userListFuture = databaseHelper.getUserList();
      userListFuture.then((userList) {
        setState(() {
          this.userList = userList;
          this.count = userList.length;
        });
      });
    });
  }
}