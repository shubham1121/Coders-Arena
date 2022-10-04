import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of user to get the current active/inactive details

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Register a new User

  Future signUpUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        debugPrint('${user.uid}signUp user');
        // await DatabaseService(user.uid)
        //     .updateUserData(name, contact, profession, isHomeOwner, email, countRoommatePost, belongsTo);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  // Login a Existing User

  Future loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'valid';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Logout a User

  Future logout() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
