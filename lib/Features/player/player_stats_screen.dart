import 'package:flutter/material.dart';

class PlayerStatsScreen extends StatelessWidget {
  final Map<String, dynamic> playerData;
  final String? teamId;

  const PlayerStatsScreen({super.key, required this.playerData, this.teamId});

  @override
  Widget build(BuildContext context) {
    if (playerData['response'] == null ||
        playerData['response'].isEmpty ||
        playerData['results'] == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Player Statistics'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.redAccent,
              ),
              SizedBox(height: 16),
              Text(
                'No player data available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please try searching again',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final player = playerData['response'][0]['player'];
    final statistics = playerData['response'][0]['statistics'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Player Statistics'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Player Profile Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(player['photo']),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player['name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Age: ${player['age']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Nationality: ${player['nationality']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Height: ${player['height']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Weight: ${player['weight']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Statistics Tabs
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.blueGrey,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.teal,
                    tabs: [
                      Tab(text: 'Current Season'),
                      Tab(text: 'Career Stats'),
                    ],
                  ),
                  SizedBox(
                    height: 500, // Adjust height as needed
                    child: TabBarView(
                      children: [
                        // Current Season Stats
                        _buildSeasonStats(statistics[0]),
                        // Career Stats
                        _buildCareerStats(statistics),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonStats(Map<String, dynamic> stats) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatSection('Team Information', [
            StatItem('Team', stats['team']['name']),
            StatItem('League', stats['league']['name']),
            StatItem('Season', stats['league']['season'].toString()),
            StatItem('Position', stats['games']['position'].toString()),
          ]),
          _buildStatSection('Appearances', [
            StatItem('Games Played', stats['games']['appearences'].toString()),
            StatItem('Minutes Played', stats['games']['minutes'].toString()),
            StatItem('Lineups', stats['games']['lineups'].toString()),
          ]),
          _buildStatSection('Goals & Assists', [
            StatItem('Goals', stats['goals']['total'].toString()),
            StatItem('Assists', stats['goals']['assists'].toString()),
            StatItem('Penalties Scored', stats['penalty']['scored'].toString()),
          ]),
        ],
      ),
    );
  }

  Widget _buildCareerStats(List<dynamic> allStats) {
    int totalGoals = 0;
    int totalAssists = 0;
    int totalAppearances = 0;

    for (var stats in allStats) {
      totalGoals += (stats['goals']['total'] ?? 0) as int;
      totalAssists += (stats['goals']['assists'] ?? 0) as int;
      totalAppearances += (stats['games']['appearences'] ?? 0) as int;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatSection('Career Overview', [
            StatItem('Total Goals', totalGoals.toString()),
            StatItem('Total Assists', totalAssists.toString()),
            StatItem('Total Appearances', totalAppearances.toString()),
          ]),
        ],
      ),
    );
  }

  Widget _buildStatSection(String title, List<StatItem> items) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 8),
            ...items.map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.label),
                  Text(
                    item.value,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class StatItem {
  final String label;
  final String value;

  StatItem(this.label, this.value);
}
