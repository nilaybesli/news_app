import 'package:flutter/material.dart';
import '../models/announcement.dart';
import '../widgets/announce_item.dart';
import '../resources/firestore_methods.dart';

class AnnouncementScreen extends StatelessWidget {
  AnnouncementScreen({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final Stream<List<Announcement>> announcement;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Announcement>>(
      stream: _firestoreMethods.getAnnounceFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final announcementList = snapshot.data ?? [];
        return announcementList.isEmpty
            ? Center(
                child: Text(
                  "Nothing here!",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              )
            : ListView.builder(
                itemCount: announcementList.length,
                itemBuilder: (context, index) {
                  return AnnounceItem(announcement: announcementList[index]);
                },
              );
      },
    );
  }
}
