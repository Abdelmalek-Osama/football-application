// lib/Screens/leagues_screen.dart
import 'package:flutter/material.dart';
import '../services/ApiService.dart';
import '../services/firestore_service.dart';

class LeaguesScreen extends StatefulWidget {
  const LeaguesScreen({super.key});

  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final ApiService _apiService = ApiService();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = true;
  List<dynamic> leagues = [];
  List<String> selectedLeagueIds = []; // List to hold selected league IDs

  @override
  void initState() {
    super.initState();
    _loadLeagues();
  }

  Future<void> _loadLeagues() async {
    try {
      final result = await _apiService.getLeagues();
      setState(() {
        leagues = result;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading leagues: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  void _toggleLeagueSelection(String leagueId, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedLeagueIds.add(leagueId); // Add league ID to the list
      } else {
        selectedLeagueIds.remove(leagueId); // Remove league ID from the list
      }
    });
  }

  Future<void> _saveSelectedLeagues() async {
    final userId = _firestoreService.getCurrentUserId(); // Get current user ID
    if (userId != null) {
      await _firestoreService.saveUserLeagues(userId, selectedLeagueIds);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Leagues saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leagues'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final league = leagues[index]['league'];
                  final leagueId = league['id'].toString(); // Assuming league has an 'id' field
                final isSelected = selectedLeagueIds.contains(leagueId);
                return CheckboxListTile(
                  title: Text(league['name'] ?? 'Unknown League'),
                  value: isSelected,
                  onChanged: (bool? value) {
                    _toggleLeagueSelection(leagueId, value ?? false);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveSelectedLeagues,
        child: Icon(Icons.save),
      ),
    );
  }
}