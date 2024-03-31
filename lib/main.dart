import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/admin/admin_login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News & Announcements',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(244, 208, 174, 1),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AdminLoginScreen(),
      //HomeScreen(news: myNewsList,),
    );
  }
}
