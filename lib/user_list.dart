import 'package:mobile_app/db/database_provider.dart';
import 'package:mobile_app/events/delete_user.dart';
import 'package:mobile_app/events/set_users.dart';
import 'package:mobile_app/inscription.dart';
import 'package:mobile_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_bloc.dart';

class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getUsers().then(
          (userList) {
        BlocProvider.of<UserBloc>(context).add(SetUsers(userList));
      },
    );
  }

  showFoodDialog(BuildContext context, User user, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.nom),
        content: Text("ID ${user.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserForm(user: user, userIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(user.id).then((_) {
              BlocProvider.of<UserBloc>(context).add(
                DeleteUser(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire food list scaffold");
    return Scaffold(
      appBar: AppBar(title: Text("UserList")),
      body: Container(
        child: BlocConsumer<UserBloc, List<User>>(
          builder: (context, userList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                print("foodList: $userList");

                User user = userList[index];
                return ListTile(
                    title: Text(user.nom, style: TextStyle(fontSize: 30)),
                    subtitle: Text(
                      "Calories: ${user.prenom}\nVegan: ${user.email}",
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () => showFoodDialog(context, user, index));
              },
              itemCount: userList.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, userList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => UserForm()),
        ),
      ),
    );
  }
}
