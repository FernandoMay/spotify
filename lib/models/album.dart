import 'dart:convert';

Albums albumsFromJson(String str) => Albums.fromJson(json.decode(str));

String albumsToJson(Albums data) => json.encode(data.toJson());

class Albums {
    Albums({
        required this.albums,
    });

    List<Album> albums;

    factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        albums: List<Album>.from(json["albums"].map((x) => Album.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "albums": List<dynamic>.from(albums.map((x) => x.toJson())),
    };
}

class Album {
    Album({
        required this.albumType,
        required this.artists,
        required this.availableMarkets,
        required this.copyrights,
        required this.externalIds,
        required this.externalUrls,
        required this.genres,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        required this.popularity,
        required this.releaseDate,
        required this.releaseDatePrecision,
        required this.tracks,
        required this.type,
        required this.uri,
    });

    String albumType;
    List<dynamic> artists;
    List<dynamic> availableMarkets;
    List<dynamic> copyrights;
    ExternalIds externalIds;
    ExternalIds externalUrls;
    List<dynamic> genres;
    String href;
    String id;
    List<dynamic> images;
    String name;
    int popularity;
    String releaseDate;
    String releaseDatePrecision;
    ExternalIds tracks;
    String type;
    String uri;

    factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: json["album_type"],
        artists: List<dynamic>.from(json["artists"].map((x) => x)),
        availableMarkets: List<dynamic>.from(json["available_markets"].map((x) => x)),
        copyrights: List<dynamic>.from(json["copyrights"].map((x) => x)),
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalIds.fromJson(json["external_urls"]),
        genres: List<dynamic>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        name: json["name"],
        popularity: json["popularity"],
        releaseDate: json["release_date"],
        releaseDatePrecision: json["release_date_precision"],
        tracks: ExternalIds.fromJson(json["tracks"]),
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "album_type": albumType,
        "artists": List<dynamic>.from(artists.map((x) => x)),
        "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
        "copyrights": List<dynamic>.from(copyrights.map((x) => x)),
        "external_ids": externalIds.toJson(),
        "external_urls": externalUrls.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "popularity": popularity,
        "release_date": releaseDate,
        "release_date_precision": releaseDatePrecision,
        "tracks": tracks.toJson(),
        "type": type,
        "uri": uri,
    };
}

class ExternalIds {
    ExternalIds();

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
    );

    Map<String, dynamic> toJson() => {
    };
}

