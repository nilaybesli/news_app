import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/announcement.dart';
import '../providers/announce_provider.dart';
import '../widgets/announce_item.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final Stream<List<Announcement>> announcement;

  @override
  Widget build(BuildContext context) {
    final announceProvider = Provider.of<AnnounceProvider>(context);

    return StreamBuilder<List<Announcement>>(
      stream: announceProvider.announceStream,
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
