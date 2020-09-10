import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/screens/user_detail.dart';
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

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.userList[position].priority),
              child: getPriorityIcon(this.userList[position].priority),
            ),

            title: Text(this.userList[position].email, style: titleStyle,),
            subtitle: Text(this.userList[position].password, style: titleStyle,),


            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, userList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.userList[position],'Edit Note');
            },

          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, User user) async {

    int result = await databaseHelper.deleteUser(user.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
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