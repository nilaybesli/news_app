import 'package:flutter/foundation.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/resources/firestore_methods.dart';

import '../admin/news_methods.dart';

class NewsProvider extends ChangeNotifier {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final NewsMethods _newsMethods = NewsMethods();

  late Stream<List<News>> _newsStream;

  Stream<List<News>> get newsStream => _newsStream;

  NewsProvider() {
    _newsStream = _firestoreMethods.getNewsFromFirestore();
  }
  Future<void> updateNews(String newsId, String newTitle, String newContent) async {
    try {
      await _newsMethods.updateNews(newsId, newTitle, newContent);
      notifyListeners();
    } catch (error) {
      print('Error updating news: $error');
      rethrow;
    }
  }
}
