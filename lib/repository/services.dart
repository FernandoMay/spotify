// import 'dart:convert';
// import 'dart:html' show Client;

// // import 'dart:html' as html;
// class AuthorizationApiProvider {
//   Client client = Client();

//   static String url = "https://accounts.spotify.com/authorize";
//   static String client_id = "3fb5a228ac954b87bda7f35a591c2c9f";
//   static String response_type = "code";
//   static String redirect_uri = "alarmfy:/";
//   static String scope = "playlist-read-private playlist-read-collaborative";
//   static String state = "34fFs29kd09";

//   String urlDireccion = "$url" +
//       "?client_id=$client_id" +
//       "&response_type=$response_type" +
//       "&redirect_uri=$redirect_uri" +
//       "&scope=$scope" +
//       "&state=$state";

//   Future<String> fetchCode() async {
//     final response = await FlutterWebAuth.authenticate(
//         url: urlDireccion, callbackUrlScheme: "alarmfy");
//     final error = Uri.parse(response).queryParameters['error'];
//     if (error == null) {
//       final code = Uri.parse(response).queryParameters['code'];
//       return code;
//     } else {
//       print("Error al autenticar");
//       return error;
//     }
//   }
// }

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/crossfade_state.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class House extends StatefulWidget {
  const House({Key? key}) : super(key: key);

  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> {
  bool _loading = false;
  bool _connected = false;
  final Logger _logger = Logger(
    //filter: CustomLogFilter(), // custom logfilter can be used to have logs in release mode
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true,
    ),
  );

  CrossfadeState? crossfadeState;
  late ImageUri? currentTrackImageUri;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: StreamBuilder<ConnectionStatus>(
        stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, snapshot) {
          _connected = false;
          var data = snapshot.data;
          if (data != null) {
            _connected = data.connected;
          }
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('SpotifySdk'),
              trailing: Row(
                children: [
                  _connected
                      ? CupertinoButton(
                          onPressed: disconnect,
                          child: const Icon(CupertinoIcons.return_icon),
                        )
                      : Container()
                ],
              ),
            ),
            // bottomNavigationBar: _connected ? _buildBottomBar(context) : null,
            child: _sampleFlowWidget(context),
          );
        },
      ),
    );
  }

  // Widget _buildBottomBar(BuildContext context) {
  //   return BottomAppBar(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             SizedIconButton(
  //               width: 50,
  //               icon: Icons.queue_music,
  //               onPressed: queue,
  //             ),
  //             SizedIconButton(
  //               width: 50,
  //               icon: Icons.playlist_play,
  //               onPressed: play,
  //             ),
  //             SizedIconButton(
  //               width: 50,
  //               icon: Icons.repeat,
  //               onPressed: toggleRepeat,
  //             ),
  //             SizedIconButton(
  //               width: 50,
  //               icon: Icons.shuffle,
  //               onPressed: toggleShuffle,
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             SizedIconButton(
  //               width: 50,
  //               onPressed: addToLibrary,
  //               icon: Icons.favorite,
  //             ),
  //             SizedIconButton(
  //               width: 50,
  //               onPressed: () => checkIfAppIsActive(context),
  //               icon: Icons.info,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _sampleFlowWidget(BuildContext context2) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    onPressed: connectToSpotifyRemote,
                    child: const Icon(CupertinoIcons.settings),
                  ),
                  CupertinoButton(
                    onPressed: getAccessToken,
                    child: const Text('get auth token '),
                  ),
                ],
              ),
              Container(
                height: 1.0,
                color: CupertinoColors.inactiveGray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
              const Text(
                'Player State',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _connected
                  ? _buildPlayerStateWidget()
                  : const Center(
                      child: Text('Not connected'),
                    ),
              Container(
                height: 1.0,
                color: CupertinoColors.inactiveGray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
              const Text(
                'Player Context',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _connected
                  ? _buildPlayerContextWidget()
                  : const Center(
                      child: Text('Not connected'),
                    ),
              Container(
                height: 1.0,
                color: CupertinoColors.inactiveGray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
              const Text(
                'Player Api',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: <Widget>[
                  CupertinoButton(
                    onPressed: seekTo,
                    child: const Text('seek to 20000ms'),
                  ),
                  CupertinoButton(
                    onPressed: seekToRelative,
                    child: const Text('seek to relative 20000ms'),
                  ),
                ],
              ),
              Container(
                height: 1.0,
                color: CupertinoColors.inactiveGray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
              const Text(
                'Crossfade State',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoButton(
                onPressed: getCrossfadeState,
                child: const Text(
                  'get crossfade state',
                ),
              ),
              // ignore: prefer_single_quotes
              Text("Is enabled: ${crossfadeState?.isEnabled}"),
              // ignore: prefer_single_quotes
              Text("Duration: ${crossfadeState?.duration}"),
            ],
          ),
          _loading
              ? Container(
                  color: CupertinoColors.black,
                  child: const Center(child: CupertinoActivityIndicator()))
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildPlayerStateWidget() {
    return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        var track = snapshot.data?.track;
        currentTrackImageUri = track?.imageUri;
        var playerState = snapshot.data;

        if (playerState == null || track == null) {
          return Center(
            child: Container(),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CupertinoButton(
                  // width: 50,
                  child: Icon(CupertinoIcons.backward_end_fill),
                  onPressed: skipPrevious,
                ),
                playerState.isPaused
                    ? CupertinoButton(
                        // width: 50,
                        child: Icon(CupertinoIcons.play_arrow),
                        onPressed: resume,
                      )
                    : CupertinoButton(
                        // width: 50,
                        child: Icon(CupertinoIcons.pause),
                        onPressed: pause,
                      ),
                CupertinoButton(
                  // width: 50,
                  child: Icon(CupertinoIcons.forward_end_fill),
                  onPressed: skipNext,
                ),
              ],
            ),
            Text(
                '${track.name} by ${track.artist.name} from the album ${track.album.name}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Playback speed: ${playerState.playbackSpeed}'),
                Text(
                    'Progress: ${playerState.playbackPosition}ms/${track.duration}ms'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Paused: ${playerState.isPaused}'),
                Text('Shuffling: ${playerState.playbackOptions.isShuffling}'),
              ],
            ),
            Text('RepeatMode: ${playerState.playbackOptions.repeatMode}'),
            Text('Image URI: ${track.imageUri.raw}'),
            Text('Is episode? ${track.isEpisode}'),
            Text('Is podcast? ${track.isPodcast}'),
            _connected
                ? spotifyImageWidget(track.imageUri)
                : const Text('Connect to see an image...'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1.0,
                  color: CupertinoColors.inactiveGray,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                ),
                const Text(
                  'Set Shuffle and Repeat',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    const Text(
                      'Repeat Mode:',
                    ),
                    CupertinoContextMenu(
                      // : RepeatMode
                      //     .values[playerState.playbackOptions.repeatMode.index],
                      actions: [
                        CupertinoContextMenuAction(
                          onPressed: () => setRepeatMode(RepeatMode.off),
                          child: Text('off'),
                        ),
                        CupertinoContextMenuAction(
                          onPressed: () => setRepeatMode(RepeatMode.track),
                          child: Text('track'),
                        ),
                        CupertinoContextMenuAction(
                          onPressed: () => setRepeatMode(RepeatMode.context),
                          child: Text('context'),
                        ),
                      ],

                      child: Container(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Set shuffle: '),
                    CupertinoSwitch(
                      value: playerState.playbackOptions.isShuffling,
                      onChanged: (bool shuffle) => setShuffle(
                        shuffle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlayerContextWidget() {
    return StreamBuilder<PlayerContext>(
      stream: SpotifySdk.subscribePlayerContext(),
      initialData: PlayerContext('', '', '', ''),
      builder: (BuildContext context, AsyncSnapshot<PlayerContext> snapshot) {
        var playerContext = snapshot.data;
        if (playerContext == null) {
          return const Center(
            child: Text('Not connected'),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${playerContext.title}'),
            Text('Subtitle: ${playerContext.subtitle}'),
            Text('Type: ${playerContext.type}'),
            Text('Uri: ${playerContext.uri}'),
          ],
        );
      },
    );
  }

  Widget spotifyImageWidget(ImageUri image) {
    return FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.large,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          } else if (snapshot.hasError) {
            setStatus(snapshot.error.toString());
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Error getting image')),
            );
          } else {
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Getting image...')),
            );
          }
        });
  }

  Future<void> disconnect() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.disconnect();
      setStatus(result ? 'disconnect successful' : 'disconnect failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString());
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<String> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  Future getPlayerState() async {
    try {
      return await SpotifySdk.getPlayerState();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future getCrossfadeState() async {
    try {
      var crossfadeStateValue = await SpotifySdk.getCrossFadeState();
      setState(() {
        crossfadeState = crossfadeStateValue;
      });
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> queue() async {
    try {
      await SpotifySdk.queue(
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> toggleRepeat() async {
    try {
      await SpotifySdk.toggleRepeat();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> setRepeatMode(RepeatMode repeatMode) async {
    try {
      await SpotifySdk.setRepeatMode(
        repeatMode: repeatMode,
      );
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> setShuffle(bool shuffle) async {
    try {
      await SpotifySdk.setShuffle(
        shuffle: shuffle,
      );
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> toggleShuffle() async {
    try {
      await SpotifySdk.toggleShuffle();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> play() async {
    try {
      await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> seekTo() async {
    try {
      await SpotifySdk.seekTo(positionedMilliseconds: 20000);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> seekToRelative() async {
    try {
      await SpotifySdk.seekToRelativePosition(relativeMilliseconds: 20000);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> addToLibrary() async {
    try {
      await SpotifySdk.addToLibrary(
          spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> checkIfAppIsActive(BuildContext context) async {
    try {
      var isActive = await SpotifySdk.isSpotifyAppActive;
      final message = isActive
          ? 'Spotify app connection is active (currently playing)'
          : 'Spotify app connection is not active (currently not playing)';

      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          message: Text(message),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    _logger.i('$code$text');
  }
}
