// lib/Screens/leagues_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/bottom_navigation.dart';
import '../constants.dart';
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
  List<String> selectedLeagueIds = [];

  @override
  void initState() {
    super.initState();
    _loadLeagues();
    _loadSelectedLeagues();
  }

  Future<void> _loadLeagues() async {
    try {
      final result = await _apiService.getLeagues();
      final userId = _firestoreService.getCurrentUserId();
      if (userId != null) {
        final savedLeagues = await _firestoreService.getUserLeagues(userId);
        setState(() {
          leagues = result;
          selectedLeagueIds = savedLeagues; // Pre-select saved leagues
          _isLoading = false;
        });
      } else {
        setState(() {
          leagues = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading leagues: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSelectedLeagues() async {
    final userId = _firestoreService.getCurrentUserId();
    if (userId != null) {
      try {
        final savedLeagues = await _firestoreService.getUserLeagues(userId);
        setState(() {
          selectedLeagueIds = savedLeagues;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading selected leagues: $e')),
        );
      }
    }
  }

  void _toggleLeagueSelection(String leagueId, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedLeagueIds.add(leagueId);
      } else {
        selectedLeagueIds.remove(leagueId);
      }
    });
  }

  Future<void> _saveSelectedLeagues() async {
    final userId = _firestoreService.getCurrentUserId();
    if (userId != null) {
      try {
        await _firestoreService.saveUserLeagues(userId, selectedLeagueIds);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Leagues saved successfully!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
          (route) =>
              false, // This removes all previous routes (including the login screen)
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving leagues: $e')),
        );
      }
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
        title: Text('Leagues', style: TextStyle(color: primaryTextColor)),
        backgroundColor: appBarBackgroundColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeTextColor,
              ),
            )
          : leagues.isEmpty
              ? Center(
                  child: Text(
                    'No leagues available.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: kBold,
                      color: primaryTextColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index]['league'];
                    final leagueId = league['id']
                        .toString(); // Assuming league has an 'id' field
                    final leagueName = league['name'] ?? 'Unknown League';
                    final leagueImageUrl = league['logo'] ??
                        ''; // Assuming league has a 'logo' field
                    final isSelected = selectedLeagueIds.contains(leagueId);

                    return Card(
                      color: cardBackgroundColor,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: leagueImageUrl.isNotEmpty
                            ? Image.network(
                                leagueImageUrl,
                                width: 50,
                                height:
                                    50, // Maintain consistent height and width for better alignment
                                fit: BoxFit
                                    .contain, // Ensure the image fits within the given dimensions
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.image_not_supported),
                              )
                            : Icon(Icons.image_not_supported, size: 50),
                        title: Text(leagueName),
                        trailing: Checkbox(
                          activeColor: orangeTextColor,
                          value: isSelected,
                          onChanged: (bool? value) {
                            _toggleLeagueSelection(leagueId, value ?? false);
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveSelectedLeagues,
        backgroundColor: orangeTextColor,
        child: Icon(
          Icons.save,
          color: primaryTextColor,
        ),
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}
