import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AutenticationService extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  Future<void> getUser() async {
    user = firebaseAuth.currentUser;
    if (user != null) {
      print(user!.displayName);
      notifyListeners();
    }
  }

  registerUser({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);

    await userCredential.user!.updateDisplayName(userName);
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('foi carai');
      
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
