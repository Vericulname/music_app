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
  int durationMs;
  String id;
  String name;
  String previewUrl;

  Track({
    required this.artists,
    required this.durationMs,
    required this.id,
    required this.name,
    required this.previewUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    durationMs: json["duration_ms"],
    id: json["id"],
    name: json["name"],
    previewUrl: json["preview_url"],
  );

  Map<String, dynamic> toJson() => {
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "duration_ms": durationMs,
    "id": id,
    "name": name,
    "preview_url": previewUrl,
  };
}

class Artist {
  String id;
  String name;

  Artist({required this.id, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) =>
      Artist(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
