import 'package:flutter/material.dart';
import 'package:news_app/models/announcement.dart';
import 'announcement_detail.dart';

class AnnounceItem extends StatelessWidget {
  const AnnounceItem({Key? key, required this.announcement}) : super(key: key);

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AnnouncementDetailScreen(announcement: announcement),
            ),
          );
        },
        child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                announcement.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                announcement.content.substring(0, 20),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
