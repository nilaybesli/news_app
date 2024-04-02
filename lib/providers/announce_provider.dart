import 'package:flutter/material.dart';
import 'package:news_app/admin/announce_methods.dart';
import 'package:news_app/models/announcement.dart';

import '../resources/firestore_methods.dart';

class AnnounceProvider with ChangeNotifier {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final AnnounceMethods _announceMethods = AnnounceMethods();

  late Stream<List<Announcement>> _announceStream;

  Stream<List<Announcement>> get announceStream => _announceStream;

  AnnounceProvider() {
    _announceStream = _firestoreMethods.getAnnounceFromFirestore();
  }

  Future<void> updateAnnounce(
      String announceId, String newTitle, String newContent) async {
    try {
      await _announceMethods.updateAnnounce(announceId, newTitle, newContent);
      _announceStream = _firestoreMethods.getAnnounceFromFirestore();
      notifyListeners();
    } catch (error) {
      print('Error updating announcement: $error');
      rethrow;
    }
  }
}
