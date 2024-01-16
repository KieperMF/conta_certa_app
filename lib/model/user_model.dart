import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  Future<void> getUser() async {
    user = firebaseAuth.currentUser;
    if (user != null) {
      notifyListeners();
    }
  }
}