class Module {

  int _idm;
  String _nomm;
  String _nbchapitres;


  Module(this._nomm, this._nbchapitres);

  Module.withId(this._idm, this._nomm, this._nbchapitres);

  int get idm => _idm;

  String get nomm => _nomm;

  String get nbchapitres => _nbchapitres;



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




  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (idm != null) {
      map['idm'] = _idm;
    }
    map['nomm'] = _nomm;
    map['nbchapitres'] = _nbchapitres;

    return map;
  }

  // Extract a Note object from a Map object
  Module.fromMapObject(Map<String, dynamic> map) {
    this._idm = map['idm'];
    this._nomm = map['nomm'];
    this._nbchapitres = map['nbchapitres'];
  }
}