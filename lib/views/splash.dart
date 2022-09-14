import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    shared_Preferences();
  }

  void shared_Preferences() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? logged = prefs.getBool('logged');
    bool logged = true;
    print("LOGGED: ${logged}");

    if (logged == true && logged != null) {
      Timer(const Duration(seconds: 0, milliseconds: 710),
          () => Navigator.pushReplacementNamed(context, "/house"));
    } else {
      Timer(const Duration(seconds: 1, milliseconds: 618),
          () => Navigator.of(context).pushReplacementNamed("/login"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: CupertinoTheme.of(context).primaryColor),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("lib/assets/spotify1.jpeg"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              color: CupertinoColors.systemGrey2.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Spotify",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: CupertinoColors.black.withOpacity(0.1),
                    height: 1.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("lib/assets/spotify44.jpeg"),
                  ),
                  const Text(
                    "Rancio Estevez",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
