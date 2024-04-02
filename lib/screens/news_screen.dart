import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/news_item.dart';
import '../resources/firestore_methods.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key, required this.news});

  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  final Stream<List<News>> news;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<News>>(
      stream: _firestoreMethods.getNewsFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final newsList = snapshot.data ?? [];
        return newsList.isEmpty
            ? Center(
                child: Text(
                  " Nothing here!",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              )
            : ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: newsList[index]);
                },
              );
      },
    );
  }
}
