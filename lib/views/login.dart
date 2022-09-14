// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'dart:html' as html;
// import 'package:http/http.dart' as http;

// // const String clientId = "3fb5a228ac954b87bda7f35a591c2c9f";

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   late String _token;
//   late html.WindowBase _popupWin;

//   static String url = "https://accounts.spotify.com/authorize";
//   static String clientId = "3fb5a228ac954b87bda7f35a591c2c9f";
//   static String response_type = "code";
//   static String redirect_uri = "alarmfy:/";
//   static String scope = "playlist-read-private playlist-read-collaborative";
//   static String state = "34fFs29kd09";

//   Future<String> _validateToken() async {
//     final response = await http.get(
//       Uri.parse('https://accounts.spotify.com/authorize'),
//       headers: {'Authorization': 'OAuth $_token'},
//     );
//     return (jsonDecode(response.body) as Map<String, dynamic>)['login']
//         .toString();
//   }

//   void _login(String data) {
//     /// Parse data to extract the token.
//     final receivedUri = Uri.parse(data);

//     /// Close the popup window
//     if (_popupWin != null) {
//       _popupWin.close();
//       // _popupWin;
//     }

//     setState(() => _token = receivedUri.fragment
//         .split('&')
//         .firstWhere((e) => e.startsWith('access_token='))
//         .substring('access_token='.length));
//   }

//   @override
//   void initState() {
//     super.initState();

//     /// Listen to message send with `postMessage`.
//     html.window.onMessage.listen((event) {
//       /// The event contains the token which means the user is connected.
//       if (event.data.toString().contains('access_token=')) {
//         _login(event.data);
//       }
//     });

//     /// You are not connected so open the Twitch authentication page.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final currentUri = Uri.base;
//       final redirectUri = Uri(
//         host: currentUri.host,
//         scheme: currentUri.scheme,
//         port: currentUri.port,
//         path: '/static.html',
//       );
//       final authUrl =
//           'https://accounts.spotify.com/authorize?response_type=$response_type&client_id=$clientId&redirect_uri=$redirect_uri&scope=$scope&state=$state';
//       _popupWin = html.window.open(
//           authUrl, "Twitch Auth", "width=800, height=900, scrollbars=yes");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Spotify oauth login')),
//       body: Center(
//         child: _token != null && _token.isNotEmpty
//             ? FutureBuilder<String>(
//                 future: _validateToken(),
//                 builder: (_, snapshot) {
//                   if (!snapshot.hasData) return CircularProgressIndicator();
//                   return Container(child: Text('Welcome ${snapshot.data}'));
//                 },
//               )
//             : Container(
//                 child: Text('You are not connected'),
//               ),
//       ),
//     );
//   }
// }
