import 'dart:convert';
import 'package:bytenews/models/show_category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews{
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=${dotenv.env['API_KEY']}";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element) {
        if(element["urlToImage"]!=null && element['description']!=null){
          ShowCategoryModel showCategoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(showCategoryModel);
        }
      });
    }

  }
}