import 'package:flutter/cupertino.dart';
import 'package:spotifyapi/models/playlist.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // extendBodyBehindAppBar: true,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        // elevation: 0,
        // leadingWidth: 140.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                // customBorder: const CircleBorder(),
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.chevron_left, size: 28.0),
                ),
              ),
              const SizedBox(width: 16.0),
              CupertinoButton(
                // customBorder: const CircleBorder(),
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.chevron_right, size: 28.0),
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          children: [
            CupertinoButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.person_alt_circle,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 8.0),
            CupertinoButton(
              padding: const EdgeInsets.only(),
              child: const Icon(CupertinoIcons.arrow_down, size: 30.0),
              onPressed: () {},
            ),
            const SizedBox(width: 20.0),
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFAF1018),
              CupertinoTheme.of(context).scaffoldBackgroundColor,
            ],
            stops: const [0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          // isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 60.0,
            ),
            children: [
              PlaylistHeader(playlist: widget.playlist),
              TracksList(tracks: widget.playlist.songs),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaylistHeader extends StatelessWidget {
  final Playlist playlist;

  const PlaylistHeader({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              playlist.imageURL,
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PLAYLIST',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navLargeTitleTextStyle!
                        .copyWith(fontSize: 12.0),
                  ),
                  const SizedBox(height: 12.0),
                  Text(playlist.name,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .tabLabelTextStyle),
                  const SizedBox(height: 16.0),
                  Text(
                    playlist.description,
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Created by ${playlist.creator} • ${playlist.songs.length} songs, ${playlist.duration}',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .dateTimePickerTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        _PlaylistButtons(followers: playlist.followers),
      ],
    );
  }
}

class _PlaylistButtons extends StatelessWidget {
  final String followers;

  const _PlaylistButtons({
    Key? key,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton.filled(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 48.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
          disabledColor: CupertinoTheme.of(context).primaryContrastingColor,
          pressedOpacity: 2.0,
          onPressed: () {},
          child: Text(
            'PLAY',
            style: CupertinoTheme.of(context)
                .textTheme
                .navActionTextStyle
                .copyWith(
                  fontSize: 12.0,
                  letterSpacing: 2.0,
                ),
          ),
        ),
        const SizedBox(width: 8.0),
        CupertinoButton(
          child: const Icon(CupertinoIcons.heart_circle),
          minSize: 30.0,
          onPressed: () {},
        ),
        CupertinoButton(
          child: const Icon(CupertinoIcons.bolt_horizontal),
          minSize: 30.0,
          onPressed: () {},
        ),
        const Spacer(),
        Text(
          'FOLLOWERS\n$followers',
          style: CupertinoTheme.of(context)
              .textTheme
              .pickerTextStyle
              .copyWith(fontSize: 12.0),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}

class TracksList extends StatelessWidget {
  final List<Song> tracks;

  const TracksList({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final selected =
            context.watch<CurrentTrackModel>().selected?.id == song.id;
    final textStyle = TextStyle(
          color: selected
              ? CupertinoTheme.of(context).primaryContrastingColor
              : CupertinoTheme.of(context).barBackgroundColor,
        );
     final headingTextStyle= CupertinoTheme.of(context)
          .textTheme
          .navLargeTitleTextStyle!
          .copyWith(fontSize: 12.0);
        List<TableRow> tableRows = [ TableRow(
          children: [
            TableCell(child: Text('TITLE',style: headingTextStyle)),
            TableCell(child: Text('ARTIST',style: headingTextStyle)),
            TableCell(child: Text('ALBUM',style: headingTextStyle)),
            TableCell(child: Icon(CupertinoIcons.timelapse)),
          ],
        ),];
    for(Song song in tracks){
      
      tableRows.add(
        TableRow(
        
          children: [
            TableCell(
              child: Text(song.title, style: textStyle),
            ),
            TableCell(
              child: Text(song.artist, style: textStyle),
            ),
            TableCell(
              child: Text(song.album, style: textStyle),
            ),
            TableCell(
              child: Text(song.duration, style: textStyle),
            ),
          ],
      );
    }
    return Table(
      
      // dataRowHeight: 54.0,
      // showCheckboxColumn: false,
      children: tableRows,
      // rows: tracks.map((e) {
        
        
        // return 
        //   selected: selected,
        //   onSelectChanged: (_) =>
        //       context.read<CurrentTrackModel>().selectTrack(e),
        // );
      // }).toList(),
    );
  }
}
