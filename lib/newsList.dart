import 'package:news_app/models/announcement.dart';

import 'models/news.dart';

List<News> myNewsList = [
  News(
    id: '1',
    title: 'Haber 1',
    category: 'Genel',
    validityDate: DateTime.now(),
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThdP9K_tohZ_fZBEYt3hvC6s4KNJ5VPc11sA&usqp=CAU',
  ),
  News(
    id: '2',
    title: 'Haber 2',
    category: 'Spor',
    validityDate: DateTime.now(),
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEfaNfUKncyRQPAT01UZvTQN28dWlg8bqEAA&usqp=CAU',
  ),
];
List<Announcement> myAnnounceList = [
  Announcement(
    id: '1',
    title: 'Duyuru 1',
     validityDate: DateTime.now(),
    imageUrl: 'https://play-lh.googleusercontent.com/yCiacUZjZ7vJ9fPvRr7IOHsGtW5_DvZKk4ajxJcu6l5zhrZX8U6BstLovR4kvDFEburM',
  ),
  Announcement(
    id: '2',
    title: 'Duyuru 2',
     validityDate: DateTime.now(),
    imageUrl: 'https://www.thedroidsonroids.com/wp-content/uploads/2020/04/Obszar-roboczy-34.png',
  ),
];