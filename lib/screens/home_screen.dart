import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/news_screen.dart';
import '../resources/firestore_methods.dart';
import 'announcement_screen.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.news}) : super(key: key);
  final Stream<List<News>> news;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    var activePageTitle = _selectedPageIndex == 0 ? 'News' : 'Announcements';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
        title: Text(
          activePageTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: _selectedPageIndex == 0
          ? NewsScreen(news: newsProvider.newsStream)
          : AnnouncementScreen(
              announcement: FirestoreMethods().getAnnounceFromFirestore(),
            ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement), label: 'Announces'),
        ],
      ),
    );
  }
}
