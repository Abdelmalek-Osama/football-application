
import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/customtext.dart';
import 'package:flutter_lab2/Features/standings/repo/standing_repo.dart';
import 'package:flutter_lab2/Features/standings/models/standingsmodel.dart';
import 'package:flutter_lab2/Features/standings/widgets/tableheaders.dart';
import 'package:flutter_lab2/Features/standings/widgets/tablerow.dart';

import '../../Custom-widgets/custom_app_bar.dart';
import '../../Custom-widgets/custom_end_drawer.dart';
import '../../Custom-widgets/side_bar.dart';
import '../../constants.dart';

class StandingviewScreen extends StatelessWidget {
  final StandingRepo standingRepo;
  StandingviewScreen({super.key, required this.standingRepo});

  Future<League> fetchMatches() async {
    return await standingRepo.getStandings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      endDrawer:  CustomEndDrawerAnimation(drawer: Sidebar()),
      appBar: CustomAppBar(title: 'Standings'),
      body: FutureBuilder<League>(
        future: fetchMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load Standing"));
          } else if (snapshot.hasData) {
            final standingList = snapshot.data!;
            return ListView(
              children: List.generate(standingList.standings.length, (index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Table(
                        border: TableBorder.all(
                          color:  primaryTextColor,
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(50), // Position column
                          1: FixedColumnWidth(400), // Team column
                          2: FixedColumnWidth(50), // MP
                          3: FixedColumnWidth(50), // W
                          4: FixedColumnWidth(50), // D
                          5: FixedColumnWidth(50), // L
                          6: FixedColumnWidth(50), // F
                          7: FixedColumnWidth(50), // A
                          8: FixedColumnWidth(50), // GD
                          9: FixedColumnWidth(50), // P
                        },
                        children: [
                          createTableHeaders(),
                          ...createStandingRows(standingList.standings[index]),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(child: Text("No standing found"));
          }
        },
      ),
    );
  }
}
