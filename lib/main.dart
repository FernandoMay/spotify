import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotifyapi/repository/services.dart';
import 'package:spotifyapi/views/albumpage.dart';
import 'package:spotifyapi/views/albumview.dart';
import 'package:spotifyapi/views/home.dart';
import 'package:spotifyapi/views/splash.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1DB954),
          brightness: Brightness.dark,
        ),
      ),
      home: const CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF1DB954),
        ),
        child: House(),
      ),
      routes: <String, WidgetBuilder>{
        '/home': (context) => const Home(),
        '/splash': (context) => const Splash(),
        '/navy': (context) => Navy(),
        '/home/albumview': (context) => const AlbumView(),
        '/home/albumpage': (context) => const AlbumPage(),
        '/house': (context) => const House(),
      },
    );
  }
}

const Color primary = Color(0xFF1DB954);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFF5f5f5f);
