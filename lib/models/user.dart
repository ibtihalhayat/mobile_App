import 'dart:convert';
import 'package:mobile_app/db/database_provider.dart';

//User userFromMapObject(String str) => User.fromMapObject(json.decode(str));

//String userToMapObject(User data) => json.encode(data.toMapObject());

class User {
  int id;
  String nom;
  String prenom;
  String email;
  String password;
  String tel;

  User({this.id, this.nom, this.prenom, this.email, this.password, this.tel});
/*
  int get id => _id;

  String get nom => _nom;

  String get prenom => _prenom;

  String get email => _email;

  String get password => _password;

  int get tel => _tel;

  set nom(String newNom) {
    this._nom = newNom;
  }

  set prenom(String newPrenom) {
    this._prenom = newPrenom;
  }

  set email(String newEmail) {
    this._email = newEmail;
  }

  set password(String newPassword) {
    this._password = newPassword;
  }

  set tel(int newTel) {
    this._tel = newTel;
  }
*/

  User.fromMap(Map<String, dynamic> map){
        id = map[DatabaseProvider.COLUMN_ID];
        nom = map[DatabaseProvider.COLUMN_NOM];
        prenom = map[DatabaseProvider.COLUMN_PRENOM];
        email = map[DatabaseProvider.COLUMN_EMAIL];
        password = map[DatabaseProvider.COLUMN_PASSWORD];
        tel = map[DatabaseProvider.COLUMN_TEL];

      }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NOM: nom,
      DatabaseProvider.COLUMN_PRENOM: prenom,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_PASSWORD: password,
      DatabaseProvider.COLUMN_TEL: tel,
    };

    if (id != null) {
    map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

}