import 'dart:convert';

import '../Model/TopHeadlineNews.dart';
import 'package:http/http.dart'as http;
class Serviceapi {
  static Future<TopHeadline> fetchTopNews() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=74587a67db6c4be6a27571bdb04de140"));
    if (response.statusCode == 200) {
      return TopHeadline.fromJson(json.decode(response.body));
    }
    throw Exception("Something went wrong");
  }

  static Future<TopHeadline> fetchTopHeadlinesByCategory(
      String category) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=74587a67db6c4be6a27571bdb04de140"));
    if (response.statusCode == 200) {
      return TopHeadline.fromJson(json.decode(response.body));
    }
    throw Exception("Something went wrong");
  }
}
