import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:footballapp/Features/standings/models/seasonmodel.dart';
import 'package:http/http.dart' as http;

class SeasonRepo {
  getAvailableSeasons() async {
    var client = http.Client();
    var url = 'https://api-football-v1.p.rapidapi.com/v3/leagues/seasons';
    // "?" +
    // Uri(queryParameters: params).query;
    try {
      var response = await client.get(Uri.parse(url), headers:{
		'x-rapidapi-key': '649a4f6d50msh8311c933f6b48d9p144f84jsn7f9f5b5121df',
		'x-rapidapi-host': 'api-football-v1.p.rapidapi.com'
	});
      Map<String, dynamic> decodedResponse = jsonDecode(response.body); 
      return Seasons.fromJson(decodedResponse);
    } finally {
      client.close();
    }
  }
}
