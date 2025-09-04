// To parse this JSON data, do
//
//     final trackModel = trackModelFromJson(jsonString);

import 'dart:convert';

TrackModel trackModelFromJson(String str) =>
    TrackModel.fromJson(json.decode(str));

String trackModelToJson(TrackModel data) => json.encode(data.toJson());

class TrackModel {
  List<Track> tracks;

  TrackModel({required this.tracks});

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
    tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
  };
}

class Track {
  List<Artist> artists;
  String name;
  String type;
  String uri;

  Track({
    required this.artists,
    required this.name,
    required this.type,
    required this.uri,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    name: json["name"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "name": name,
    "type": type,
    "uri": uri,
  };
}

class Artist {
  ExternalUrls externalUrls;
  String id;
  String name;
  String type;
  String uri;

  Artist({
    required this.externalUrls,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    id: json["id"],
    name: json["name"],
    type: json["type"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls.toJson(),
    "id": id,
    "name": name,
    "type": type,
    "uri": uri,
  };
}

class ExternalUrls {
  String spotify;

  ExternalUrls({required this.spotify});

  factory ExternalUrls.fromJson(Map<String, dynamic> json) =>
      ExternalUrls(spotify: json["spotify"]);

  Map<String, dynamic> toJson() => {"spotify": spotify};
}
