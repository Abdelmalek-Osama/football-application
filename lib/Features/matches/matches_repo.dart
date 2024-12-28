import 'dart:convert';
import 'package:footballapp/Features/matches/tomatches_model.dart';
import 'package:http/http.dart' as http;

class TodayMatchesRepo {
  getTodayMatches(String res) async {
    var client = http.Client();
    var url = "https://api-football-v1.p.rapidapi.com/v3/fixtures?$res";
    // "?" +
    // Uri(queryParameters: params).query;
    try {
      var response = await client.get(Uri.parse(url), headers: {
        'x-rapidapi-key': '649a4f6d50msh8311c933f6b48d9p144f84jsn7f9f5b5121df',
        'x-rapidapi-host': 'api-football-v1.p.rapidapi.com'
      });
      //print(response.body);
      List decodedResponse = jsonDecode(response.body)["response"];
      return decodedResponse.map((e) => NextFixturesModel.fromJson(e)).toList();
    } finally {
      client.close();
    }
  }
}
