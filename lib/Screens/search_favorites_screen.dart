import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class SearchFavoritesScreen extends StatefulWidget {
  @override
  _SearchFavoritesScreenState createState() => _SearchFavoritesScreenState();
}

class _SearchFavoritesScreenState extends State<SearchFavoritesScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController _emailController = TextEditingController();
  List<Map<String, dynamic>> _favorites = [];
  String? _errorMessage;

  Future<void> _searchFavorites() async {
    setState(() {
      _favorites = [];
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final userId = await firestoreService.getUserIdByEmail(email);

    if (userId != null) {
      final favorites = await firestoreService.getUserFavorites(userId);
      setState(() {
        _favorites = favorites;
      });
    } else {
      setState(() {
        _errorMessage = 'User not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Favorites')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter user email'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchFavorites,
              child: Text('Search'),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 10),
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            ],
            Expanded(
              child: ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  final player = _favorites[index];
                  return ListTile(
                    title: Text(player['name']),
                    subtitle: Text(player['position']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 