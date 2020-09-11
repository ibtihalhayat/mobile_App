class Module {

  int _idm;
  String _nomm;
  String _nbchapitres;
  String _datem;
  int _prioritym;


  Module(this._nomm, this._nbchapitres, this._datem, this._prioritym);

  Module.withId(this._idm, this._nomm, this._nbchapitres, this._datem, this._prioritym);

  int get idm => _idm;

  String get nomm => _nomm;

  String get nbchapitres => _nbchapitres;

  int get prioritym => _prioritym;

  String get datem => _datem;


  set nomm(String newNomm) {
    if (newNomm.length <= 255) {
      this._nomm = newNomm;
    }
  }

  set nbchapitres(String newNbchapitres) {
    if (newNbchapitres.length <= 255) {
      this._nbchapitres = newNbchapitres;
    }
  }


  set prioritym(int newPrioritym) {
    if (newPrioritym >= 1 && newPrioritym <= 2) {
      this._prioritym = newPrioritym;
    }
  }

  set datem(String newDatem) {
    this._datem = newDatem;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (idm != null) {
      map['idm'] = _idm;
    }
    map['nomm'] = _nomm;
    map['nbchapitres'] = _nbchapitres;
    map['prioritym'] = _prioritym;
    map['datem'] = _datem;

    return map;
  }

  // Extract a Note object from a Map object
  Module.fromMapObject(Map<String, dynamic> map) {
    this._idm = map['idm'];
    this._nomm = map['nomm'];
    this._nbchapitres = map['nbchapitres'];
    this._prioritym = map['prioritym'];
    this._datem = map['datem'];
  }
}