/*import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid,
  );

  //mail and password
Future<String> createUserWithEmailAndPassword(String nom, String prenom, String email, String password) async{
  final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  //nom et prenom
  var userUpdate = UserUpdateInfo();
  userUpdateInfo.displayName = name;

}

}*/