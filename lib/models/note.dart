class Note {

  int _id;
  String _nom;
  String _prenom;
  String _email;
  String _password;
  String _tel;
  String _date;
  int _priority;


  Note(this._nom, this._prenom, this._email, this._password,this._tel,  this._date, this._priority);

  Note.withId(this._id, this._nom, this._prenom, this._email, this._password,this._tel,  this._date, this._priority);

  int get id => _id;

  String get nom => _nom;

  String get prenom => _prenom;

  String get email => _email;

  String get password => _password;

  String get tel => _tel;

  int get priority => _priority;

  String get date => _date;


  set nom(String newNom) {
    if (newNom.length <= 255) {
      this._nom = newNom;
    }
  }

  set prenom(String newPrenom) {
    if (newPrenom.length <= 255) {
      this._prenom = newPrenom;
    }
  }

  set email(String newEmail) {
    if (newEmail.length <= 255) {
      this._email = newEmail;
    }
  }

  set password(String newPassword) {
    if (newPassword.length <= 255) {
      this._password = newPassword;
    }
  }

  set tel(String newTel) {
    if (newTel.length <= 255) {
      this._tel = newTel;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['nom'] = _nom;
    map['prenom'] = _prenom;
    map['email'] = _email;
    map['password'] = _password;
    map['tel'] = _tel;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._prenom = map['prenom'];
    this._email = map['email'];
    this._password = map['password'];
    this._tel = map['tel'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}