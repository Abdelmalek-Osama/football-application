import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID (UID)
      String userId = userCredential.user!.uid;

      // Create a document in the 'users' collection with the UID as the document ID
      await _db.collection('users').doc(userId).set({
        'email': email,
        // Add other user-related fields if needed
      });

      return userCredential.user;
    } catch (e) {
      print("Error during registration: $e");
      return null;
    }
  }
} 