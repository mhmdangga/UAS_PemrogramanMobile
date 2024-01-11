import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix/global/cummon/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // registrasi
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-sudah-pernah-digunakan") {
        showToast(message: 'Email sudah pernah digunakan');
      } else {
        showToast(message: "Terjadi error: ${e.code}");
      }
    }
    return null;
  }

  // login
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Email-tidak-ada' || e.code == 'password-salah') {
        showToast(message: 'Password dan email tidak benar');
      } else {
        showToast(message: "Terjadi error: ${e.code}");
      }
    }
    return null;
  }
}
