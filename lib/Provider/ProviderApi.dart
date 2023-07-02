import 'package:flutter/cupertino.dart';

import '../Model/TopHeadlineNews.dart';
import '../Network/NewsServices.dart';

class CategoryProvider extends ChangeNotifier {
  String _selectedCategory = 'All';
  Future<TopHeadline>? _news;
  String get selectedCategory => _selectedCategory;
  Future<TopHeadline>? get news => _news;

  void setCategory(String category) {
    _selectedCategory = category;
    refreshNews();
    notifyListeners();
  }

  Future<void> refreshNews() async {
    if (_selectedCategory == 'All') {
      _news = Serviceapi.fetchTopNews();
    } else {
      _news = Serviceapi.fetchTopHeadlinesByCategory(_selectedCategory);
    }
    notifyListeners();
  }
}