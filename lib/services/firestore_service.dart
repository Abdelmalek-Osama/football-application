import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavoritePlayer(Map<String, dynamic> playerData) async {
    final user = _auth.currentUser; // Get the current user
    if (user == null) {
      throw Exception("User not authenticated");
    }
    await _db
        .collection('users')
        .doc(user.uid)
        .set({'email': user.email});

    final favoritesCollection =
        _db.collection('users').doc(user.uid).collection('favorites');

    // Log the player data being added
    if (kDebugMode) {
      print("Adding player data: $playerData");
    }

    // Check if the player already exists in favorites
    final existingPlayer = await favoritesCollection
        .where('name', isEqualTo: playerData['name'])
        .get();

    if (existingPlayer.docs.isNotEmpty) {
      throw Exception(
          '${playerData['name']} is already in favorites!'); // Throw an exception if player exists
    }

    try {
      // If not, add the player to favorites
      await favoritesCollection.add(playerData);
      if (kDebugMode) {
        print("Player added to favorites: ${playerData['name']}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding player to favorites: $e");
      } // Log any errors
      throw Exception('Failed to add player to favorites: $e');
    }
  }

  Future<void> removeFavoritePlayer(String playerName) async {
    final favoritesCollection = _db.collection('favorites');
    final existingPlayer =
        await favoritesCollection.where('name', isEqualTo: playerName).get();

    if (existingPlayer.docs.isNotEmpty) {
      await favoritesCollection
          .doc(existingPlayer.docs.first.id)
          .delete(); // Remove the player
    }
  }

  Future<List<Map<String, dynamic>>> getFavoritePlayers() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get();
      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    }
    return [];
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid; // Helper method to get the current user ID
  }

  CollectionReference getFavoritesCollection() {
    return _db
        .collection('favorites'); // Return the favorites collection reference
  }

  Future<List<Map<String, dynamic>>> getUserFavorites(String userId) async {
    final favoritesCollection =
        _db.collection('users').doc(userId).collection('favorites');
    final snapshot = await favoritesCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<String?> getUserIdByEmail(String email) async {
    final snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id; // Return the user ID (UID)
    }
    return null; // Return null if no user found
  }
  
  Future<void> saveUserLeagues(String userId, List<String> leagueIds) async {
    await _db.collection('users').doc(userId).set({
      'favoriteLeagues': leagueIds, // Save the list of league IDs
    }, SetOptions(merge: true)); // Use merge to avoid overwriting other fields
  }
}
