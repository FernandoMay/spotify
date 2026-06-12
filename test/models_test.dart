import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:spotifyapi/models/album.dart';
import 'package:spotifyapi/models/artist.dart';
import 'package:spotifyapi/models/auth.dart';
import 'package:spotifyapi/models/playlist.dart';

void main() {
  group('Album model', () {
    test('fromJson creates Albums from valid JSON', () {
      final json = jsonEncode({
        'albums': [
          {
            'album_type': 'album',
            'artists': [],
            'available_markets': [],
            'copyrights': [],
            'external_ids': <String, dynamic>{},
            'external_urls': <String, dynamic>{},
            'genres': [],
            'href': 'https://api.spotify.com/v1/albums/1',
            'id': '1',
            'images': [],
            'name': 'Test Album',
            'popularity': 50,
            'release_date': '2024-01-01',
            'release_date_precision': 'day',
            'tracks': <String, dynamic>{},
            'type': 'album',
            'uri': 'spotify:album:1',
          }
        ]
      });
      final albums = albumsFromJson(json);
      expect(albums.albums, hasLength(1));
      expect(albums.albums.first.name, 'Test Album');
    });

    test('toJson produces valid JSON string', () {
      final album = Album(
        albumType: 'album',
        artists: [],
        availableMarkets: [],
        copyrights: [],
        externalIds: ExternalIds(),
        externalUrls: ExternalIds(),
        genres: [],
        href: 'https://api.spotify.com/v1/albums/1',
        id: '1',
        images: [],
        name: 'Test Album',
        popularity: 50,
        releaseDate: '2024-01-01',
        releaseDatePrecision: 'day',
        tracks: ExternalIds(),
        type: 'album',
        uri: 'spotify:album:1',
      );
      final albums = Albums(albums: [album]);
      final result = albumsToJson(albums);
      expect(result, contains('Test Album'));
    });
  });

  group('Artist model', () {
    test('fromJson creates Artists from valid JSON', () {
      final json = jsonEncode({
        'artists': [
          {
            'external_urls': <String, dynamic>{},
            'followers': <String, dynamic>{},
            'genres': [],
            'href': 'https://api.spotify.com/v1/artists/1',
            'id': '1',
            'images': [],
            'name': 'Test Artist',
            'popularity': 80,
            'type': 'artist',
            'uri': 'spotify:artist:1',
          }
        ]
      });
      final artists = artistsFromJson(json);
      expect(artists.artists, hasLength(1));
      expect(artists.artists.first.name, 'Test Artist');
    });

    test('toJson produces valid JSON string', () {
      final artist = Artist(
        externalUrls: ExternalUrls(),
        followers: ExternalUrls(),
        genres: [],
        href: 'https://api.spotify.com/v1/artists/1',
        id: '1',
        images: [],
        name: 'Test Artist',
        popularity: 80,
        type: 'artist',
        uri: 'spotify:artist:1',
      );
      final artists = Artists(artists: [artist]);
      final result = artistsToJson(artists);
      expect(result, contains('Test Artist'));
    });
  });

  group('AuthorizationModel model', () {
    test('fromJson creates AuthorizationModel from valid JSON', () {
      final json = {
        'access_token': 'token123',
        'token_type': 'Bearer',
        'expires_in': 3600,
        'refresh_token': 'refresh123',
        'scope': 'playlist-read',
      };
      final auth = AuthorizationModel.fromJson(json);
      expect(auth.accessToken, 'token123');
      expect(auth.tokenType, 'Bearer');
      expect(auth.expiresIn, 3600);
    });

    test('toJson produces expected map', () {
      final auth = AuthorizationModel(
        accessToken: 'token123',
        tokenType: 'Bearer',
        expiresIn: 3600,
        refreshToken: 'refresh123',
        scope: 'playlist-read',
      );
      final result = auth.toJson();
      expect(result['access_token'], 'token123');
      expect(result['expires_in'], 3600);
    });
  });

  group('Playlist model', () {
    test('Playlist constructor assigns fields', () {
      final songs = [
        const Song(
          id: '1',
          title: 'Song 1',
          artist: 'Artist 1',
          album: 'Album 1',
          duration: '3:30',
        ),
      ];
      final playlist = Playlist(
        id: 'pl1',
        name: 'Test Playlist',
        imageURL: 'assets/test.jpg',
        description: 'A test playlist',
        creator: 'Test Creator',
        duration: '1h 30m',
        followers: '100',
        songs: songs,
      );
      expect(playlist.name, 'Test Playlist');
      expect(playlist.songs, hasLength(1));
      expect(playlist.songs.first.title, 'Song 1');
    });
  });
}
