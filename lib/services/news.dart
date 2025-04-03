import 'package:bytenews/models/article_model.dart';
import 'package:http/http.dart';

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2025-03-02&sortBy=publishedAt&apiKey=a47e7903f2984016880269ddbbf4ed70";
    var response = await http.get(url);
  }
}