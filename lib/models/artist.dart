
import 'dart:convert';

Artists artistsFromJson(String str) => Artists.fromJson(json.decode(str));

String artistsToJson(Artists data) => json.encode(data.toJson());

class Artists {
    Artists({
        required this.artists,
    });

    List<Artist> artists;

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    };
}

class Artist {
    Artist({
        required this.externalUrls,
        required this.followers,
        required this.genres,
        required this.href,
        required this.id,
        required this.images,
        required this.name,
        required this.popularity,
        required this.type,
        required this.uri,
    });

    ExternalUrls externalUrls;
    ExternalUrls followers;
    List<dynamic> genres;
    String href;
    String id;
    List<dynamic> images;
    String name;
    int popularity;
    String type;
    String uri;

    factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: ExternalUrls.fromJson(json["followers"]),
        genres: List<dynamic>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        name: json["name"],
        popularity: json["popularity"],
        type: json["type"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "followers": followers.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "popularity": popularity,
        "type": type,
        "uri": uri,
    };
}

class ExternalUrls {
    ExternalUrls();

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    );

    Map<String, dynamic> toJson() => {
    };
}
