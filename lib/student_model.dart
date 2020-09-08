class Student {
  int id;
  String name;
  String prenom;
  String email;
  String password;
  String tel;
  Student(this.id, this.name, this.prenom, this.email, this.password);//, this.tel);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'prenom': prenom,
      'email': email,
      'password': password,
  //    'tel': tel,
    };
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    prenom = map['prenom'];
    email = map['email'];
    password = map['password'];
//    tel = map['tel'];
  }
}