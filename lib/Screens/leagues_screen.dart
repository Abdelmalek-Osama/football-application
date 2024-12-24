// lib/Screens/leagues_screen.dart
import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class LeaguesScreen extends StatefulWidget {
  @override
  _LeaguesScreenState createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  List<dynamic> leagues = [];

  @override
  void initState() {
    super.initState();
    _loadLeagues();
  }

  Future<void> _loadLeagues() async {
    try {
      final result = await _apiService.getLeagues();
      
      // Ensure the response is a List and assign to `leagues`
      setState(() {
        leagues = result; // Since `getLeagues` already returns a List of leagues
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading leagues: $e')),
      );
      setState(() => _isLoading = false);
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
          : leagues.isEmpty
              ? Center(child: Text('No leagues available'))
              : ListView.builder(
                  itemCount: leagues.length,
                  itemBuilder: (context, index) {
                    final league = leagues[index]['league']; // Access league info
                    final country = leagues[index]['country']; // Access country info
                    return ListTile(
                      title: Text(league['name'] ?? 'Unknown League'),
                      subtitle: Text(country['name'] ?? 'Unknown Country'),
                      leading: league['logo'] != null
                          ? Image.network(
                              league['logo'],
                              height: 40,
                              width: 40,
                            )
                          : null,
                    );
                  },
                ),
    );
  }
}
