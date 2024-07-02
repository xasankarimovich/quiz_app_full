import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final authServices = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await authServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await authServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await authServices.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await authServices.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
