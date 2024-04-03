import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:news_app/admin/news_methods.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';

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
  String? _imageURL;

  void _addNews() {
    if (_titleController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _imageURL == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select an image.'),
        ),
      );
      return;
    }
    NewsMethods().addNews(
      _titleController.text,
      _contentController.text,
      _categoryController.text,
      _imageURL!,
    );
    _titleController.clear();
    _contentController.clear();
    _categoryController.clear();
    setState(() {
      _imageURL = null;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

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
        body: NewsScreen(
          news: newsProvider.newsStream,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageInput(
                    onSelectImage: (imageFile) async {
                      final bytes = await imageFile.readAsBytes();
                      final imageURL = await NewsMethods()
                          .uploadImage(Uint8List.fromList(bytes));

                      setState(() {
                        _imageURL = imageURL;
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
                  const SizedBox(height: 10),
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
          ),
        );
      },
    );
  }
}
