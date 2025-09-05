import 'package:music_app/data/model/track_model.dart';
import 'package:music_app/data/provider/track_provider.dart';

abstract class ITrackRepos {
  Future<TrackModel> getTrack(String id);
}

class TrackRepos implements ITrackRepos {
  final Trackprovider trackprovider;

  TrackRepos(this.trackprovider);

  @override
  Future<TrackModel> getTrack(String id) {
    return trackprovider.getTrack(id);
  }
}
