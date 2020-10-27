class Chapitre {

  int _idc;
  String _nomcours;
  String _numchapitre;
  String _done;

//Les Constructeurs
  Chapitre(this._nomcours, this._numchapitre, this._done);

  Chapitre.withId(this._idc, this._nomcours, this._numchapitre, this._done);

  //Les GETTERS
  int get idc => _idc;

  String get nomcours => _nomcours;

  String get numchapitre => _numchapitre;

  String get done => _done;


//Les Setters
  set nomcours(String newNomcours) {
      this._nomcours = newNomcours;
  }

  set numchapitre(String newNumchapitre) {
    this._numchapitre = newNumchapitre;
  }

  set done(String newDone) {
      this._done = newDone;
  }




  // Convertir un object chapitre en Map objet
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (idc != null) {
      map['idc'] = _idc;
    }
    map['nomcours'] = _nomcours;
    map['numchapitre'] = _numchapitre;
    map['done'] = _done;

    return map;
  }

  // Extraire un objet chapitre depuis Map objet
  Chapitre.fromMapObject(Map<String, dynamic> map) {
    this._idc = map['idc'];
    this._nomcours = map['nomcours'];
    this._numchapitre = map['numchapitre'];
    this._done = map['done'];
  }
}