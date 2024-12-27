import 'package:flutter/material.dart';

import '../../../Custom-widgets/customtext.dart';
import '../../../constants.dart';

TableCell createTableCell(String text, [bool isHeader = false]) {
  return TableCell(
    child: Container(
      color: isHeader ? const Color(0xFF205295) : const Color(0xFF2C74B3),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: CustomText(
            text: text,
            colours: isHeader ? Color(0xFF000000) : primaryTextColor,
            fontSize: 15,
            isBold: isHeader,
          )),
    ),
  );
}
