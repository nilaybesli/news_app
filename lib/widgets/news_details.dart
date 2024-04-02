import 'package:flutter/material.dart';
import 'package:news_app/admin/news_methods.dart';
import 'package:news_app/models/news.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/news_provider.dart';

class NewsDetails extends StatefulWidget {
  final News news;

  const NewsDetails({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  void deleteNews(BuildContext context, String newsId) async {
    try {
      await NewsMethods().deleteNews(newsId);
      Navigator.of(context).pop();
    } catch (error) {
      print('Error deleting news: $error');
    }
  }

  void editNews(
      BuildContext context, String newTitle, String newContent) async {
    try {
      await Provider.of<NewsProvider>(context, listen: false).updateNews(widget.news.id, newTitle, newContent);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (error) {
      print('Error updating news: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
    TextEditingController(text: widget.news.title);
    TextEditingController contentController =
    TextEditingController(text: widget.news.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Edit the News'),
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
                          editNews(context, titleController.text,
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
            onPressed: () => deleteNews(context, widget.news.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: widget.news.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(widget.news.imageUrl),
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.news.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.news.content,
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
