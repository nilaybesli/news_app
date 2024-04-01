import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/admin/news_methods.dart';
import 'package:news_app/widgets/image_input.dart';

class NewsAdminScreen extends StatefulWidget {
  const NewsAdminScreen({Key? key}) : super(key: key);

  @override
  _NewsAdminScreenState createState() => _NewsAdminScreenState();
}

class _NewsAdminScreenState extends State<NewsAdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  void _addNews() {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _selectedImage == null) {
      return;
    }
    NewsMethods().addNews(
      _titleController.text,
      _contentController.text,
      _selectedImage!,
    );
    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedImage = null;
    });
    Navigator.of(context).pop();
  }

  void _updateNews() {}

  void _deleteNews() {}

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                addShowModalBottomSheet(context);
              },
              child: const Text(
                'Add News',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _updateNews,
              child: const Text(
                'Update News',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _deleteNews,
              child: const Text(
                'Delete News',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
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
                ImageInput(
                  onSelectImage: (imageFile) {
                    setState(() {
                      _selectedImage = imageFile;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
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
