class Module {
  int id;
  String namem;
  String nbchapitres;
  Module(this.id, this.namem);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'namem': namem,
    };
    return map;
  }

  Module.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    namem = map['namem'];
  }
}