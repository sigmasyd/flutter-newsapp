import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '7c1ea2687f0f4c1794121eff4f1ab80e';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
      //this.categoryArticles[item.name] = List.empty();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String category) {
    this._selectedCategory = category;
    this.getArticlesByCategory(category);

    notifyListeners();
  }

  getTopHeadlines() async {
    //print('Cargando healines...');
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if(this.categoryArticles[category].length>0){
      return this.categoryArticles[category];
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
