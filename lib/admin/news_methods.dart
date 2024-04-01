import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewsMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addNews(String title, String content, File imageFile) async {
    try {
      String imageURL = await _uploadImage(imageFile);

      await _firestore.collection('news').add({
        'title': title,
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
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask;
      final imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }
}
