import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewsMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addNews(
      String title, String content, String category, File imageFile) async {
    try {
      String imageURL = await _uploadImage(imageFile);

      await _firestore.collection('news').add({
        'title': title,
        'category': category,
        'content': content,
        'imageURL': imageURL,
      });
    } catch (error) {
      print('Error adding news: $error');
      throw error;
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('news_images/$imageName.jpg');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }
  Future<void> deleteNews(String newsId) async {
    try {
      await _firestore.collection('news').doc(newsId).delete();
    } catch (error) {
      print('Error deleting news: $error');
      throw error;
    }
  }

  Future<void> updateNews(String newsId, String newTitle, String newContent) async {
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

