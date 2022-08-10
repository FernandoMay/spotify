import 'package:flutter/cupertino.dart';
import 'package:spotifyapi/views/albumpage.dart';
import 'package:spotifyapi/views/albumview.dart';
import 'package:spotifyapi/views/home.dart';
import 'package:spotifyapi/views/splash.dart';

void main() {
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
      home: Splash(),
      // routes: <String, WidgetBuilder>{
      //   //'/login': (BuildContext context) => Login(),
      //   '/home': (context) => Home(),
      //   '/splash': (context) => Splash(),
      //   '/navy': (context) => Navy(),
      //   '/home/albumview': (context) => const AlbumView(),
      //   '/home/albumpage': (context) => const AlbumPage(),
      //   //'/musicdetail':(context) => Musi
      //   //'/wait': (BuildContext context) => Wait(),
      // },
    );
  }
}

const Color primary = Color(0xFF04be4e);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFF5f5f5f);
