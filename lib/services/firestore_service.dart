import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavoritePlayer(Map<String, dynamic> playerData) async {
    final playerName = playerData['name'];
    final favoritesCollection = _db.collection('favorites');

    // Check if the player already exists in favorites
    final existingPlayer = await favoritesCollection
        .where('name', isEqualTo: playerName)
        .get();

    if (existingPlayer.docs.isNotEmpty) {
      throw Exception('$playerName is already in favorites!'); // Throw an exception if player exists
    }

    // If not, add the player to favorites
    await favoritesCollection.add(playerData);
  }

  Future<void> removeFavoritePlayer(String playerName) async {
    final favoritesCollection = _db.collection('favorites');
    final existingPlayer = await favoritesCollection
        .where('name', isEqualTo: playerName)
        .get();

    if (existingPlayer.docs.isNotEmpty) {
      await favoritesCollection.doc(existingPlayer.docs.first.id).delete(); // Remove the player
    }
  }

  Future<List<Map<String, dynamic>>> getFavoritePlayers() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final snapshot = await _db.collection('users').doc(userId).collection('favorites').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    }
    return [];
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid; // Helper method to get the current user ID
  }

  CollectionReference getFavoritesCollection() {
    return _db.collection('favorites'); // Return the favorites collection reference
  }

  Future<List<Map<String, dynamic>>> getUserFavorites(String userId) async {
    final favoritesCollection = _db.collection('users').doc(userId).collection('favorites');
    final snapshot = await favoritesCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  
} 