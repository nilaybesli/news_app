import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/news.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNews(News news) async {
    try {
      await _firestore.collection('news').add(news.toMap());
    } catch (e) {
      print('Error adding news to Firestore: $e');
    }
  }

  Stream<List<News>> getNewsFromFirestore() {
    try {
      return _firestore.collection('news').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return News.fromMap(doc.data());
        }).toList();
      });
    } catch (e) {
      print('Error getting news from Firestore: $e');
      return const Stream.empty();
    }
  }
}
