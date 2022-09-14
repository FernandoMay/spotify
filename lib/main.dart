import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotifyapi/repository/services.dart';
import 'package:spotifyapi/views/albumpage.dart';
import 'package:spotifyapi/views/albumview.dart';
import 'package:spotifyapi/views/home.dart';
import 'package:spotifyapi/views/login.dart';
import 'package:spotifyapi/views/musicdetail.dart';
import 'package:spotifyapi/views/splash.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

CupertinoThemeData ctheme() {
  return const CupertinoThemeData(
    primaryColor: primary,
    brightness: Brightness.dark,
    textTheme: CupertinoTextThemeData(
      primaryColor: black,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'spotify',
      theme: ctheme(),
      debugShowCheckedModeBanner: false,
      home: const House(),
      routes: <String, WidgetBuilder>{
        // '/login': (BuildContext context) => Login(),
        '/home': (context) => const Home(),
        '/splash': (context) => const Splash(),
        '/navy': (context) => Navy(),
        '/home/albumview': (context) => const AlbumView(),
        '/home/albumpage': (context) => const AlbumPage(),
        '/house': (context) => const House(),

        // '/musicdetail':(context) => MusicDetailPage(title: context., description: description, color: color, img: img, songUrl: songUrl)
        // '/wait': (BuildContext context) => Wait(),
      },
    );
  }
}

const Color primary = Color(0xFF04be4e);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFF5f5f5f);
