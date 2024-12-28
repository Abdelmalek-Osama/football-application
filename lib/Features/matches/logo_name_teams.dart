import 'package:flutter/material.dart';
import 'package:footballapp/Custom-widgets/customtext.dart';
import 'package:footballapp/constants.dart';

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
