import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/admin/admin_login.dart';
import 'package:news_app/admin/announce_admin_screen.dart';
import 'package:news_app/admin/news_admin_screen.dart';
import 'package:news_app/providers/announce_provider.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/resources/firestore_methods.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDyNz03DjBQg17Ty-xiuGcJSl94pt7TjvM",
      appId: "1:500230385651:web:02137867332bc081f72c86",
      messagingSenderId: "500230385651",
      projectId: "news-app-5b8e1",
      storageBucket: "news-app-5b8e1.appspot.com",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => AnnounceProvider()),
      ],
      child: MaterialApp(
        title: 'News & Announcements',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(244, 208, 174, 1),
          ),
          textTheme: GoogleFonts.latoTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const AnnounceAdminScreen(),
      ),
    );
  }
}
