import 'package:flutter/material.dart';
import 'package:footballapp/Features/standings/repo/season_repo.dart';
import 'package:footballapp/Features/standings/repo/standing_repo.dart';
import 'package:footballapp/Features/standings/standingspicking.dart';
import 'package:footballapp/Features/standings/standingview.dart';
import 'package:footballapp/Features/team/team_search_screen.dart';
import 'package:footballapp/Features/matches/matches.dart';
import 'package:footballapp/Features/matches/matches_repo.dart';
import 'package:footballapp/Features/news/news.dart';
import 'package:footballapp/Features/news/todaynews.dart';
import 'package:footballapp/Features/player/player_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _navIndex = 0;

  void goToProfileScreen() {
    setState(() => _navIndex = 3);
  }

  void goToOrders() {
    setState(() => _navIndex = 2);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      TodayMatches(todayMatchesRepo: TodayMatchesRepo()),
      NewsScreen(todayNewsRepo: Todaynews()),
      StandingviewScreen(standingRepo: StandingRepo()),
      PlayerScreen(),
      TeamSearchScreen(),
    ];
    return Scaffold(
      body: IndexedStack(index: _navIndex, children: screens),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        child: NavigationBar(
          height: 60,
          selectedIndex: _navIndex,
          onDestinationSelected: (i) => setState(() => _navIndex = i),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.stadium_outlined),
              selectedIcon: Icon(Icons.stadium),
              label: 'Matches',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper),
              selectedIcon: Icon(Icons.newspaper),
              label: 'News',
            ),
            NavigationDestination(
              icon: Icon(Icons.stacked_line_chart),
              selectedIcon: Icon(Icons.stacked_line_chart),
              label: 'Standings',
            ),
            NavigationDestination(
              icon: Icon(Icons.run_circle_outlined),
              selectedIcon: Icon(Icons.run_circle_outlined),
              label: 'Players',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Teams',
            ),
          ],
        ),
      ),
    );
  }
}
