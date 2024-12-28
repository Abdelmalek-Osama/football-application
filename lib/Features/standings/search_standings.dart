import 'package:flutter/material.dart';
import 'package:footballapp/Custom-widgets/customtext.dart';
import 'package:footballapp/Features/standings/repo/season_repo.dart';
import 'package:footballapp/Features/standings/models/seasonmodel.dart';
import 'package:footballapp/Features/standings/repo/standing_repo.dart';
import 'package:footballapp/Features/standings/standingview.dart';
import 'package:footballapp/constants.dart';
import 'package:footballapp/services/firestore_service.dart';

class SearchStandingsScreen extends StatefulWidget {
  final SeasonRepo seasonRepo;

  const SearchStandingsScreen({super.key, required this.seasonRepo});

  @override
  _SearchStandingsScreenState createState() => _SearchStandingsScreenState();
}

class _SearchStandingsScreenState extends State<SearchStandingsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = true;
  List<String> selectedLeagueIds = [];
  String? _selectedLeague;
  String? _selectedSeason;

  @override
  void initState() {
    super.initState();
    _loadSelectedLeagues();
  }

  Future<void> _loadSelectedLeagues() async {
    try {
      final userId = _firestoreService.getCurrentUserId();
      if (userId != null) {
        final savedLeagues = await _firestoreService.getUserLeagues(userId);
        setState(() {
          selectedLeagueIds = savedLeagues;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading leagues: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Seasons> _fetchSeasons() async {
    try {
      return await widget.seasonRepo.getAvailableSeasons();
    } catch (e) {
      debugPrint('Error fetching seasons: $e');
      throw Exception('Failed to load seasons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: CustomText(
          text: "Search Standings",
          isBold: true,
          fontSize: 24,
          colours: primaryTextColor,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // League Dropdown
                  CustomText(
                    text: "Select a League",
                    isBold: true,
                    fontSize: 20,
                    colours: primaryTextColor,
                  ),
                  const SizedBox(height: 8),
                  selectedLeagueIds.isNotEmpty
                      ? DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: const Text("Select League"),
                          value: _selectedLeague,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLeague = newValue;
                            });
                          },
                          items: selectedLeagueIds.map((league) {
                            return DropdownMenuItem<String>(
                              value: league,
                              child: Text(league),
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: Text("No leagues available"),
                        ),
                  const SizedBox(height: 16),

                  // Season Dropdown
                  CustomText(
                    text: "Select a Season",
                    isBold: true,
                    fontSize: 20,
                    colours: primaryTextColor,
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<Seasons>(
                    future: _fetchSeasons(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Failed to load seasons"),
                        );
                      } else if (snapshot.hasData) {
                        final seasons = snapshot.data!;
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: const Text("Select Season"),
                          value: _selectedSeason,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSeason = newValue;
                            });
                          },
                          items: seasons.response.map((season) {
                            return DropdownMenuItem<String>(
                              value: season.toString(),
                              child: Text(season.toString()),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Center(
                            child: Text("No seasons available"));
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Search Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_selectedLeague != null && _selectedSeason != null) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StandingviewScreen(
                              standingRepo: StandingRepo(),
                              leagueId: _selectedLeague!,
                              season: _selectedSeason!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select both league and season',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Search Standings',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
