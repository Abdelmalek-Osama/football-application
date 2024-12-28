import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Login with Google
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      return await _auth.signInWithCredential(cred);
    } catch (e) {
      log("Google sign-in error: ${e.toString()}");
    }
    return null;
  }

  // Create a new user with email and password
  Future<User?> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Error in register: ${e.toString()}");
    }
    return null;
  }

  // Login with email and password
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Error in login: ${e.toString()}");
    }
    return null;
  }

  // Sign out the user
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error in sign-out: ${e.toString()}");
    }
  }
}
