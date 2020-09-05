import 'package:mobile_app/events/add_user.dart';
import 'package:mobile_app/events/delete_user.dart';
import 'package:mobile_app/events/user_event.dart';
import 'package:mobile_app/events/set_users.dart';
import 'package:mobile_app/events/update_user.dart';
import 'package:mobile_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, List<User>> {
  @override
  List<User> get initialState => List<User>();

  @override
  Stream<List<User>> mapEventToState(UserEvent event) async* {
    if (event is SetUsers) {
      yield event.userList;
    } else if (event is AddUser) {
      List<User> newState = List.from(state);
      if (event.newUser != null) {
        newState.add(event.newUser);
      }
      yield newState;
    } else if (event is DeleteUser) {
      List<User> newState = List.from(state);
      newState.removeAt(event.userIndex);
      yield newState;
    } else if (event is UpdateUser) {
      List<User> newState = List.from(state);
      newState[event.userIndex] = event.newUser;
      yield newState;
    }
  }
}


























/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/user.dart';
import 'package:mobile_app/events/add_user.dart';
import 'package:mobile_app/events/delete_user.dart';
import 'package:mobile_app/events/user_event.dart';
import 'package:mobile_app/events/set_users.dart';

class UserBloc extends Bloc<UserEvent, List<User>> {
  @override
  List<User> get initialState => List<User>();

  @override
  Stream<List<User>> mapEventToState(UserEvent event) async* {
    if (event is SetUsers) {
      yield event.userList;
    } else if (event is AddUser) {
      List<User> newState = List.from(state);
      if (event.newUser != null) {
        newState.add(event.newUser);
      }
      yield newState;
    } else if (event is DeleteUser) {
      List<User> newState = List.from(state);
      newState.removeAt(event.userIndex);
      yield newState;
    }
  }
}
*/