import 'dart:convert';
import 'package:footballapp/Features/news/newsmodel.dart';
import 'package:http/http.dart' as http;

class Todaynews {
  getTodayNews() async {
    var client = http.Client();
    var url =
        "https://allscores.p.rapidapi.com/api/allscores/news?sport=1&timezone=America%2FChicago&langId=1";

    try {
      var response = await client.get(Uri.parse(url), headers: {
        'x-rapidapi-key': "09f207794bmshc204a41601b62e4p146a60jsna9768e38c60d",
        'x-rapidapi-host': "allscores.p.rapidapi.com"
      });
    // print("response news: ${response.body}");
      List decodedResponse = jsonDecode(response.body)["news"];
      return decodedResponse.map((e) => News.fromJson(e)).toList();
    } finally {
      client.close();
    }
  }
}