// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/data/model/track_model.dart';

sealed class TrackState extends Equatable {}

final class TrackStateInitial extends TrackState {
  @override
  List<Object?> get props => [];
}

final class TrackStateLoading extends TrackState {
  @override
  List<Object?> get props => [];
}

final class TrackStateSucees extends TrackState {
  final TrackModel trackModel;

  TrackStateSucees(this.trackModel);

  @override
  List<Object?> get props => [trackModel];
}

final class TrackStateError extends TrackState {
  final String error;

  TrackStateError(this.error);

  @override
  List<Object?> get props => [error];
}
