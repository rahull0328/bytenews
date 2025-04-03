import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bytenews/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String apiKey = dotenv.env['API_KEY'] ?? ''; // Fetch API key from .env

    if (apiKey.isEmpty) {
      print("API Key is missing!");
      return;
    }

    String url = "https://newsapi.org/v2/everything?q=tesla&from=2025-03-02&sortBy=publishedAt&apiKey=$apiKey";

    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              content: element['content'],
              author: element['author'],
            );
            news.add(articleModel);
          }
        });
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }
}
