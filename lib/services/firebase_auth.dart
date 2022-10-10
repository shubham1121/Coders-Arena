import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth ;

  AuthService(this._auth);

  // Stream of user to get the current active/inactive details

  Stream<User?> get authStateChange {
    return _auth.authStateChanges();
  }

  // Register a new User

  Future signUpUser(String email, String password) async {
    try {
      UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return e;
    }
  }

  // Login a Existing User

  Future<dynamic> loginUser(String email, String password) async {
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return e.message;
    }
  }

  // Google Signup

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(signInOption: SignInOption.standard).signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Logout a User

  Future logout(User user) async {
    try {
      var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(user.email!);
      if(methods.contains('google.com')) {
        GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.disconnect();
      }
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
