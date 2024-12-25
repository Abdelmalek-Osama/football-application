// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'services/ApiService.dart';
import 'Screens/team_search_screen.dart';
import 'Screens/player_stats_screen.dart';
import 'Screens/favorites_screen.dart';
import 'Screens/leagues_screen.dart'; // Import the LeaguesScreen
import 'Screens/search_favorites_screen.dart'; // Import the SearchFavoritesScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _playerController = TextEditingController();
  final TextEditingController _teamController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _searchPlayer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await _apiService.searchPlayer(
        playerName: _playerController.text,
        teamName: _teamController.text,
      );
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerStatsScreen(
            playerData: result,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching for player: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Transfer Tracker'),
        backgroundColor: Color(0xFF205295),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 9, 9, 9), // Set background color to white
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _playerController,
                  decoration: InputDecoration(
                    labelText: 'Enter player name',
                    labelStyle: TextStyle(color: Color(0xFF2C74B3)),
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Color(0xFF144272).withOpacity(0.5),
                  ),
                  style: TextStyle(color: Color(0xFF2C74B3)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a player name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _teamController,
                  decoration: InputDecoration(
                    labelText: 'Enter team name',
                    labelStyle: TextStyle(color: Color(0xFF2C74B3)),
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Color(0xFF144272).withOpacity(0.5),
                  ),
                  style: TextStyle(color: Color(0xFF2C74B3)),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a team name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2647),
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    foregroundColor: Color(0xFF2C74B3),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamSearchScreen()),
                  ),
                  child: Text(
                    'Search Teams',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C74B3),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0A2647),
                          minimumSize: Size(200, 50),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          foregroundColor: Color(0xFF2C74B3),
                        ),
                        onPressed: _searchPlayer,
                        child: Text(
                          'Search Player',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C74B3),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2647),
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    foregroundColor: Color(0xFF2C74B3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaguesScreen()),
                    );
                  },
                  child: Text(
                    'Go to Leagues',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C74B3),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2647),
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    foregroundColor: Color(0xFF2C74B3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesScreen()),
                    );
                  },
                  child: Text(
                    'Go to Favorites',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C74B3),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2647),
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    foregroundColor: Color(0xFF2C74B3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchFavoritesScreen()),
                    );
                  },
                  child: Text(
                    'Search User Favorites',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C74B3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    _teamController.dispose();
    super.dispose();
  }
}