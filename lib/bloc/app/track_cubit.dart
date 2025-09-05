import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/app/track_state.dart';
import 'package:music_app/data/model/track_model.dart';
import 'package:music_app/data/repository/track_repos.dart';

class TrackCubit extends Cubit<TrackState> {
  final TrackRepos _trackRepos;
  bool _hasFetch = false;

  TrackCubit(this._trackRepos) : super(TrackStateInitial());

  Future<void> fetchTrack(String id) async {
    if (_hasFetch && state is TrackStateLoading) {
      return;
    }

    emit(TrackStateLoading());

    try {
      final track = await _trackRepos.getTrack(id);
      _hasFetch = true;
      emit(TrackStateSucees(track));
    } catch (e) {
      emit(TrackStateError(e.toString()));
    }
  }

  Future<void> refreshTrack(String id) async {
    _hasFetch = false;
    await fetchTrack(id);
  }
}
