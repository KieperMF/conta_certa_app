import 'package:firebase_auth/firebase_auth.dart';

class AutenticationService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      print("nao foi");
      return e.message;
    }
  }

  Future<void> logout() {
    return firebaseAuth.signOut();
  }
}
