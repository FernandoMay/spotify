import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late String _token;
  late html.WindowBase _popupWin;

  Future<String> _validateToken() async {
    final response = await http.get(
      Uri.parse('https://id.twitch.tv/oauth2/validate'),
      headers: {'Authorization': 'OAuth $_token'},
    );
    return (jsonDecode(response.body) as Map<String, dynamic>)['login']
        .toString();
  }

  void _login(String data) {
    /// Parse data to extract the token.
    final receivedUri = Uri.parse(data);

    /// Close the popup window
    if (_popupWin != null) {
      _popupWin.close();
      _popupWin = null;
    }

    setState(() => _token = receivedUri.fragment
        .split('&')
        .firstWhere((e) => e.startsWith('access_token='))
        .substring('access_token='.length));
  }

  @override
  void initState() {
    super.initState();

    /// Listen to message send with `postMessage`.
    html.window.onMessage.listen((event) {
      /// The event contains the token which means the user is connected.
      if (event.data.toString().contains('access_token=')) {
        _login(event.data);
      }
    });

    /// You are not connected so open the Twitch authentication page.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUri = Uri.base;
      final redirectUri = Uri(
        host: currentUri.host,
        scheme: currentUri.scheme,
        port: currentUri.port,
        path: '/static.html',
      );
      final authUrl =
          'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=$clientId&redirect_uri=$redirectUri&scope=viewing_activity_read';
      _popupWin = html.window.open(
          authUrl, "Twitch Auth", "width=800, height=900, scrollbars=yes");
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Twitch web login')),
      child: Center(
        child: _token != null && _token.isNotEmpty
            ? FutureBuilder<String>(
                future: _validateToken(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return CupertinoActivityIndicator();
                  return Container(child: Text('Welcome ${snapshot.data}'));
                },
              )
            : Container(
                child: Text('You are not connected'),
              ),
      ),
    );
  }
}
