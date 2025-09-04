import "package:dio/dio.dart";
import "package:music_app/data/model/track_model.dart";

class Trackprovider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://spotify23.p.rapidapi.com/tracks/?ids=",
      headers: {
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com",
        "X-RapidAPI-Key": "604e3ca56amshafe4950bc3dd704p114ce7jsnf229fab0a896",
      },
    ),
  );

  Future<TrackModel> getTrack() async {
    try {
      final response = await _dio.get("4WNcduiCmDNfmTEz7JvmLv");
      return trackModelFromJson(response.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
