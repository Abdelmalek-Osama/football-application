import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: firestoreService.getFavoritePlayers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final favorites = snapshot.data ?? [];
          if (favorites.isEmpty) {
            return Center(child: Text('No favorite players found.'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return ListTile(
                title: Text(favorite['name']),
                subtitle: Text(favorite['position']),
                leading: favorite['photoUrl'] != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(favorite['photoUrl']),
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}

