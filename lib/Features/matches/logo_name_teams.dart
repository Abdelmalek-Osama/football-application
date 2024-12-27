import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/customtext.dart';
import 'package:flutter_lab2/constants.dart';

logoNameTeams({required String logo, required String name}) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.network(
          logo,
          height: 40,
          width: 40,
          fit: BoxFit.fill,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      const SizedBox(width: 30),
      CustomText(
        text: name,
        isBold: true,
        colours: primaryTextColor,
        fontSize: 15,
      )
    ],
  );
}
