import 'package:flutter/material.dart';
import 'package:footballapp/Features/standings/repo/season_repo.dart';
import 'package:footballapp/Features/standings/search_standings.dart';

import '../constants.dart';
import 'customtext.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool search;

  CustomAppBar({super.key, required this.title, this.search = false})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBackgroundColor,
      title: CustomText(
        text: title,
        isBold: true,
        fontSize: 26,
        colours: primaryTextColor,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      leading: search
          ? IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchStandingsScreen(seasonRepo: SeasonRepo()),
                  ),
                );
              },
            )
          : null,
    );
  }
}
