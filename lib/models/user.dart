class User {

  int _id;
  String _nom;
  String _prenom;
  String _email;
  String _password;
  String _tel;

//Les Constructeurs
  User(this._nom, this._prenom, this._email, this._password,this._tel);

  User.withId(this._id, this._nom, this._prenom, this._email, this._password,this._tel);

  //Les Getters
  int get id => _id;

  String get nom => _nom;

  String get prenom => _prenom;

  String get email => _email;

  String get password => _password;

  String get tel => _tel;


//Les Setters
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




  // Convertir un objet user en Map objet
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

    return map;
  }

  // Extraire un objet user depuis Map objet
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._prenom = map['prenom'];
    this._email = map['email'];
    this._password = map['password'];
    this._tel = map['tel'];
  }
}