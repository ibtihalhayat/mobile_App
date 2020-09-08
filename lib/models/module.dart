/*import 'package:mobile_app/db/database_provider_module.dart';

class Module {
  int id;
  String nom;
  String nbchapitres;

  Module({this.id, this.nom,this.nbchapitres });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NOM: nom,
      DatabaseProvider.COLUMN_NBCHAPITRES: nbchapitres,
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Module.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    nom = map[DatabaseProvider.COLUMN_NOM];
    nbchapitres = map[DatabaseProvider.COLUMN_NBCHAPITRES];
  }
}*/
