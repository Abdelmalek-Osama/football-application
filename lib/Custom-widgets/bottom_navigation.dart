import 'package:flutter/material.dart';
import 'package:flutter_lab2/Screens/team_search_screen.dart';
import 'package:flutter_lab2/filo/matches.dart';
import 'package:flutter_lab2/filo/matches_repo.dart';
import 'package:flutter_lab2/filo/news.dart';
import 'package:flutter_lab2/filo/todaynews.dart';
import 'package:flutter_lab2/home_screen.dart';

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
      HomeScreen(),
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
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Matches',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper),
              selectedIcon: Icon(Icons.newspaper),
              label: 'News',
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
