import 'package:flutter/cupertino.dart';

import '../Model/TopHeadlineNews.dart';
import '../Network/NewsServices.dart';

class CategoryProvider extends ChangeNotifier {
  Future<TopHeadline>? _news;
  Future<TopHeadline>? get news => _news;
  String? selectedCategory;

  void setCategory(String category) {
    if (category == 'All') {
      _news = Serviceapi.fetchTopNews();
    } else {
      _news = Serviceapi.fetchTopHeadlinesByCategory(category);
    }
    notifyListeners();
  }

  Future<void> refreshNews() async {

    if (selectedCategory == "All") {
      _news = Serviceapi.fetchTopNews();
    } else {
      _news = Serviceapi.fetchTopHeadlinesByCategory(selectedCategory!);
    }
notifyListeners();
  }
}
