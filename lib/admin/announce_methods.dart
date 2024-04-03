import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AnnounceMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  Future<void> addAnnounce(String title, String content) async {
    try {
      String announceId = _uuid.v4();

      await _firestore.collection('announcement').doc(announceId).set({
        'id': announceId,
        'title': title,
        'content': content,
      });
    } catch (error) {
      print('Error adding announce: $error');
      rethrow;
    }
  }

  Future<void> deleteAnnounce(String announceId) async {
    try {
      await _firestore.collection('announcement').doc(announceId).delete();
    } catch (error) {
      print('Error deleting announcement: $error');
      rethrow;
    }
  }

  Future<void> updateAnnounce(
      String announceId, String newTitle, String newContent) async {
    try {
      await _firestore.collection('announcement').doc(announceId).update({
        'title': newTitle,
        'content': newContent,
      });
    } catch (e) {
      print("Error updating announce: $e");
    }
  }
}
