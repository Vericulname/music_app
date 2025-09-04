import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/app/track_state.dart';
import 'package:music_app/data/repository/track_repos.dart';

class TrackCubit extends Cubit<TrackState> {
  final TrackRepos _trackRepos;

  TrackCubit(this._trackRepos) : super(TrackStateInitial());

  Future<void> fetchTrack() async {
    emit(TrackStateLoading());
    try {
      final track = await _trackRepos.getTrack();

      emit(TrackStateSucees(track));
    } catch (e) {
      emit(TrackStateError(e.toString()));
    }
  }
}
