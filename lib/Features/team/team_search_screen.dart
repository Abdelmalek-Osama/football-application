import 'package:flutter/material.dart';
import '../../Custom-widgets/custom_app_bar.dart';
import '../../Custom-widgets/custom_end_drawer.dart';
import '../../Custom-widgets/side_bar.dart';
import '../../services/ApiService.dart';
import 'team_stats_screen.dart';
import 'team_players_screen.dart';

class TeamSearchScreen extends StatefulWidget {
  const TeamSearchScreen({super.key});

  @override
  _TeamSearchScreenState createState() => _TeamSearchScreenState();
}

class _TeamSearchScreenState extends State<TeamSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  Map<String, dynamic>? teamData;
  String? selectedTeamId;

  Future<void> _searchTeam() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final result = await _apiService.searchTeam(_teamController.text);
      setState(() {
        teamData = result;
        selectedTeamId = result['response'][0]['team']['id'].toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching for team: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
      if (teamData != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TeamStatsScreen(
              teamData: teamData!,
              teamId: selectedTeamId!,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:  CustomEndDrawerAnimation(drawer: Sidebar()),
      appBar:CustomAppBar(title: 'Search Team'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/footbackground.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _teamController,
                  decoration: InputDecoration(
                    labelText: 'Enter team name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a team name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(200, 50),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _searchTeam,
                        child: Text(
                          'Search Team',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _teamController.dispose();
    super.dispose();
  }
}
