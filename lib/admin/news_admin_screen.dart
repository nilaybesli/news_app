import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/admin/news_methods.dart';
import 'package:news_app/resources/firestore_methods.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/widgets/image_input.dart';

import '../models/news.dart';

class NewsAdminScreen extends StatefulWidget {
  const NewsAdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NewsAdminScreenState createState() => _NewsAdminScreenState();
}

class _NewsAdminScreenState extends State<NewsAdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  File? _selectedImage;

  void _addNews() {
    if (_titleController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _selectedImage == null) {
      return;
    }
    NewsMethods().addNews(
      _titleController.text,
      _contentController.text,
      _categoryController.text,
      _selectedImage!,
    );
    _titleController.clear();
    _contentController.clear();
    _categoryController.clear();
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
    _categoryController.dispose();
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
        title: const Text('News Management'),
      ),
      body: NewsScreen(news: FirestoreMethods().getNewsFromFirestore(),)


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
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
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
