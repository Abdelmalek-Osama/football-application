import 'dart:convert';
import 'package:flutter_lab2/filo/newsmodel.dart';
import 'package:http/http.dart' as http;

class Todaynews {
  getTodayNews() async {
    var client = http.Client();
    var url =
        "https://allscores.p.rapidapi.com/api/allscores/news?sport=1&timezone=America%2FChicago&langId=1";

    try {
      var response = await client.get(Uri.parse(url), headers: {
        'x-rapidapi-key': "649a4f6d50msh8311c933f6b48d9p144f84jsn7f9f5b5121df",
        'x-rapidapi-host': "allscores.p.rapidapi.com"
      });
    // print(response.body);
      List decodedResponse = jsonDecode(response.body)["news"];
      return decodedResponse.map((e) => News.fromJson(e)).toList();
    } finally {
      client.close();
    }
  }
}