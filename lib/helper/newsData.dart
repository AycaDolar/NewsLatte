import 'dart:convert';

import 'package:http/http.dart' as http;

class Article {
  String? title;
  String? author;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? postUrl;
  String? category;
  Article(
      {required this.title,
      required this.description,
      required this.author,
      required this.content,
      required this.publishedAt,
      required this.urlToImage,
      required this.postUrl,
      required this.category});
}

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=tr&apiKey=881a33126ed349e9871fc98780559aad");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        var time = DateTime.parse(element['publishedAt']);
        String currentTime =
            (time.hour.toString() + " : " + time.minute.toString());
        String category = "Turkey";
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: currentTime,
            content: element["content"],
            postUrl: element["url"],
            category: category,
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategory {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=678285814d4f4a7daf387be758d14571");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          var time = DateTime.parse(element['publishedAt']);
          String currentTime =
              (time.hour.toString() + " : " + time.minute.toString());
          Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: currentTime,
              content: element["content"],
              postUrl: element["url"],
              category: category);
          news.add(article);
        },
      );
    }
  }
}
