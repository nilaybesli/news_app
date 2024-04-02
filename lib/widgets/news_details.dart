import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:transparent_image/transparent_image.dart';

import '../admin/news_methods.dart';

class NewsDetails extends StatelessWidget {
  final News news;

  const NewsDetails({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void deleteNews() {
      NewsMethods().deleteNews(news.id);
      Navigator.of(context).pop();
    }

    void editNews() {

      NewsMethods().updateNews(news.id, news.title, news.content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit), // Add edit icon
            onPressed: editNews, // Call edit function
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteNews,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: news.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(news.imageUrl),
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
                    news.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.content,
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
