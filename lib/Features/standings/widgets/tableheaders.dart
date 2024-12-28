import 'package:flutter/material.dart';
import 'package:footballapp/Features/standings/widgets/tablecell.dart';

TableRow createTableHeaders() {
  return TableRow(
    children: [
      createTableCell('Pos', true),
      createTableCell('Team', true),
      createTableCell('MP', true),
      createTableCell('W', true),
      createTableCell('D', true),
      createTableCell('L', true),
      createTableCell('F', true),
      createTableCell('A', true),
      createTableCell('GD', true),
      createTableCell('P', true),
    ],
  );
}
