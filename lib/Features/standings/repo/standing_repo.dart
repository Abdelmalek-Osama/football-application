import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_lab2/Features/standings/models/standingsmodel.dart';
import 'package:http/http.dart' as http;

class StandingRepo {
  getStandings() async {
    var client = http.Client();
    var url =
        'https://api-football-v1.p.rapidapi.com/v3/standings?league=39&season=2024';
    // "?" +
    // Uri(queryParameters: params).query;
    try {
      var response = await client.get(Uri.parse(url), headers: {
        'x-rapidapi-key': '649a4f6d50msh8311c933f6b48d9p144f84jsn7f9f5b5121df',
        'x-rapidapi-host': 'api-football-v1.p.rapidapi.com'
      });
      if (kDebugMode) {
        print(response.body);
      }
      Map<String, dynamic> decodedResponse =
          jsonDecode(response.body)["response"][0]["league"];
      League league = League.fromJson(decodedResponse);
      return league;
    } finally {
      client.close();
    }
  }
}
