import "dart:math";

import "package:dio/dio.dart";
import "package:music_app/data/model/track_model.dart";

class Trackprovider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://spotify81.p.rapidapi.com/tracks/?ids=",
      headers: {
        "X-RapidAPI-Host": "spotify81.p.rapidapi.com",
        "X-RapidAPI-Key": "604e3ca56amshafe4950bc3dd704p114ce7jsnf229fab0a896",
      },
    ),
  );

  Future<TrackModel> getTrack(String id, {int tries = 3}) async {
    for (var i = 0; i < 3; i++) {
      try {
        final response = await _dio.get(id);
        if (response.statusCode == 200) {
          return trackModelFromJson(response.toString());
        } else if (response.statusCode == 429) {
          await Future.delayed(Duration(seconds: pow(2, i).toInt()));
          continue;
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 429 && i < tries) {
          await Future.delayed(Duration(seconds: pow(2, i).toInt()));
          continue;
        }
        rethrow;
      }
    }
    throw Exception("lỗi sau khi thử $tries lần");
  }
}
