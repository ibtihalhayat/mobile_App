import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid,
  );

  //mail and password sign up
  Future<String> createUserWithEmailAndPassword(String email, String password , String nom) async{
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final FirebaseUser user =  result.user;
    //nom et prenom
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nom;
    await user.updateProfile(userUpdateInfo);
    await user.reload();
    return user.uid;
  }



  // mail and pass sign in
  Future<String> signInWithEmailAndPassword(String email, String password) async{
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user =  result.user;
    return user.uid;
  }


//sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

}