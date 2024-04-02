import 'package:flutter/material.dart';
import '../resources/firestore_methods.dart';
import '../screens/announcement_screen.dart';
import 'announce_methods.dart';

class AnnounceAdminScreen extends StatefulWidget {
  const AnnounceAdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AnnounceAdminScreen createState() => _AnnounceAdminScreen();
}

class _AnnounceAdminScreen extends State<AnnounceAdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _addNews() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }
    AnnounceMethods().addAnnounce(
      _titleController.text,
      _contentController.text,
    );
    _titleController.clear();
    _contentController.clear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            addShowModalBottomSheet(context);
          },
        ),
        appBar: AppBar(
          title: const Text('Announcement Management'),
        ),
        body: AnnouncementScreen(
          announcement: FirestoreMethods().getAnnounceFromFirestore(),
        ));
  }

  Future<dynamic> addShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Content'),
                  maxLines: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: _addNews,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
