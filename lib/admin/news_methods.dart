import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class NewsMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<void> addNews(
      String title, String content, String category, String imageURL) async {
    try {
      String newsId = _uuid.v4();

      await _firestore.collection('news').doc(newsId).set({
        'id': newsId,
        'title': title,
        'category': category,
        'content': content,
        'imageURL': imageURL,
      });
    } catch (error) {
      print('Error adding news: $error');
      rethrow;
    }
  }

  Future<String> uploadImage(Uint8List imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('news_images/$imageName.jpg');

      UploadTask uploadTask = ref.putData(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;

    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<void> deleteNews(String newsId) async {
    try {
      await _firestore.collection('news').doc(newsId).delete();
    } catch (error) {
      print('Error deleting news: $error');
      rethrow;
    }
  }

  Future<void> updateNews(
      String newsId, String newTitle, String newContent) async {
    try {
      await _firestore.collection('news').doc(newsId).update({
        'title': newTitle,
        'content': newContent,
      });
    } catch (e) {
      print("Error updating news: $e");
    }
  }
}
