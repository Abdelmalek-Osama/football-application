import 'package:flutter/material.dart';
import 'package:flutter_lab2/filo/matches.dart';
import 'package:flutter_lab2/filo/matches_repo.dart';

void main() {
  runApp(const FootballApp());
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodayMatches(todayMatchesRepo: TodayMatchesRepo())
        //    home: NewsScreen(todayNewsRepo: Todaynews()),
        );
  }
}
