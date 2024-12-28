
import 'package:flutter/material.dart';
import 'package:footballapp/Custom-widgets/customtext.dart';
import 'package:footballapp/Features/standings/repo/season_repo.dart';
import 'package:footballapp/Features/standings/models/seasonmodel.dart';
import 'package:footballapp/constants.dart';

class StandingPicking extends StatelessWidget {
  final SeasonRepo seasonRepo;
  StandingPicking({super.key, required this.seasonRepo});
  Future<List<Seasons>> fetchSeasons() async {
    return await seasonRepo.getAvailableSeasons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBarBackgroundColor,
          title: Center(
            child: CustomText(
              text: "Seasons",
              isBold: true,
              fontSize: 30,
              colours: primaryTextColor,
            ),
          ),
        ),
        body: FutureBuilder<List<Seasons>>(
            future: fetchSeasons(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Failed to load seasons"));
              } else if (snapshot.hasData) {
                final seasonlist = snapshot.data!;
                return Column(children: [
                  ...List.generate(seasonlist.length, (index) {
                    return Center();
                  })
                  
                ]);
              }
            else{
                return const Center();}}));
  }
}
