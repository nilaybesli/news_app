import 'package:flutter/material.dart';
import 'package:news_app/admin/announce_methods.dart';
import 'package:provider/provider.dart';
import 'package:news_app/models/announcement.dart';
import '../providers/announce_provider.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({Key? key, required this.announcement})
      : super(key: key);

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  void deleteAnnouncement(BuildContext context, String announceId) async {
    try {
      await AnnounceMethods().deleteAnnounce(announceId);
      Navigator.of(context).pop();
    } catch (error) {
      print('Error deleting announcement: $error');
    }
  }

  void editAnnouncement(
      BuildContext context, String newTitle, String newContent) async {
    try {
      await Provider.of<AnnounceProvider>(context, listen: false).updateAnnounce(widget.announcement.id, newTitle, newContent);
      Navigator.of(context).pop();
     } catch (error) {
      print('Error updating announcement: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: widget.announcement.title);
    TextEditingController contentController =
        TextEditingController(text: widget.announcement.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.announcement.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Edit the Announcement'),
                    content: Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                          ),
                          TextField(
                            controller: contentController,
                            decoration:
                                const InputDecoration(labelText: 'Content'),
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {

                          editAnnouncement(context, titleController.text,
                              contentController.text);

                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () =>
                deleteAnnouncement(context, widget.announcement.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.announcement.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.announcement.content,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
