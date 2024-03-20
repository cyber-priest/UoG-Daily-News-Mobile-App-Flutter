import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  AuthProvider(this._firebaseAuth);

  Stream<User> get user => _firebaseAuth.authStateChanges();
  Future<UserCredential> singIn(email, password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  signUp(email, password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print(error.message);
    }
  }

  singOut() async {
    await _firebaseAuth.signOut();
  }
  forgotPass(email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
