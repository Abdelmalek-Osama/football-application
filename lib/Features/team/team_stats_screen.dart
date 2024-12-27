import 'package:flutter/material.dart';
import 'package:flutter_lab2/Features/team/team_players_screen.dart';

import '../../constants.dart';

class TeamStatsScreen extends StatelessWidget {
  final Map<String, dynamic> teamData;
  final String? teamId;

  const TeamStatsScreen({
    super.key,
    required this.teamData,
    this.teamId,
  });

  @override
  Widget build(BuildContext context) {
    final team = teamData['response'][0]['team'];
    final venue = teamData['response'][0]['venue'];
    print('Team Data: $teamData');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Team Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: appBarBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        team['logo'],
                        height: 90,
                        width: 90,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Founded: ${team['founded']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            'Country: ${team['country']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Venue Information
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stadium Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Name: ${venue['name']}'),
                    Text('City: ${venue['city']}'),
                    Text('Address: ${venue['address']}'),
                    Text('Capacity: ${venue['capacity']}'),
                    if (venue['surface'] != null)
                      Text('Surface: ${venue['surface']}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Button for players
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: appBarBackgroundColor,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamPlayersScreen(
                      teamData: teamData,
                      teamId: teamId,
                    ),
                  ),
                ),
                child: Text(
                  'View Players',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Venue Image
            if (venue['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  venue['image'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
