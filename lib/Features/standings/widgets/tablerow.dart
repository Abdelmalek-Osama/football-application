import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/customtext.dart';
import 'package:flutter_lab2/Features/standings/models/standingsmodel.dart';
import 'package:flutter_lab2/Features/standings/widgets/tablecell.dart';

import '../../../constants.dart';

List<TableRow> createStandingRows(List<Standing> standings) {
  return standings.map((standing) {
    return TableRow(
      children: [
        createTableCell('${standing.rank}', true), // Position
        TableCell(
          child: Row(
            children: [
              standing.team?.logo != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: Image.network(
                        standing.team!.logo!,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(width: 20),
              CustomText(
                  text: standing.team?.name ?? 'Unknown',
                  isBold: true,
                  colours: primaryTextColor,
                  fontSize: 14)
            ],
          ),
        ),
        createTableCell('${standing.all?.played ?? 0}'), // MP
        createTableCell('${standing.all?.win ?? 0}'), // W
        createTableCell('${standing.all?.draw ?? 0}'), // D
        createTableCell('${standing.all?.lose ?? 0}'), // L
        createTableCell('${standing.all?.goals?.goalsFor ?? 0}'), // F
        createTableCell('${standing.all?.goals?.against ?? 0}'), // A
        createTableCell('${standing.goalsDiff ?? 0}'), // GD
        createTableCell('${standing.points ?? 0}'), // P
      ],
    );
  }).toList();
}
