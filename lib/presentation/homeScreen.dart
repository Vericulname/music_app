import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/bloc/app/track_state.dart';
import 'package:music_app/data/constants/enum.dart';

import 'package:music_app/data/constants/string.dart';
import 'package:music_app/data/model/track_model.dart';
import 'package:music_app/presentation/wiget/customButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = true;

  bool isLoadind = false;

  late AudioPlayer player;

  Duration _duration = const Duration();
  Duration _pos = const Duration();

  FetchTrackState? fetchState;

  Track? curTrack;

  List<Track> trackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Image.asset(dics, width: 300, height: 300),
              10.verticalSpace,
              curTrack != null ? Text(curTrack!.name) : SizedBox(),
              40.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    icons: Icons.replay_10,
                    onPressed: () {
                      if (curTrack != null) {
                        player.seek(Duration(seconds: _pos.inSeconds - 10));
                      }
                    },
                  ),
                  // 10.horizontalSpace,
                  CustomButton(
                    icons: isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: () async {
                      if (curTrack == null) return;

                      if (isPlaying) {
                        await player.pause();
                      } else {
                        if (player.audioSource != null) {
                          await player.play();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("lỗi khi cố phát nhạc")),
                          );
                        }
                      }
                    },
                  ),
                  // 10.horizontalSpace,
                  CustomButton(
                    icons: Icons.forward_10,
                    onPressed: () {
                      if (curTrack != null) {
                        player.seek(Duration(seconds: _pos.inSeconds + 10));
                      }
                    },
                  ),
                ],
              ),
              Slider(
                value: _pos.inSeconds.toDouble(),

                onChanged: (val) async {
                  await player.seek(Duration(seconds: val.toInt()));
                },
                min: 0,
                max: _duration.inSeconds.toDouble(),
              ),
              Text("${_formatDuration(_pos)}/${_formatDuration(_duration)}"),
              BlocListener<TrackCubit, TrackState>(
                listener: (BuildContext context, TrackState state) {
                  if (state is TrackStateLoading) {
                    fetchState = FetchTrackState.loading;
                  } else if (state is TrackStateError) {
                    fetchState = FetchTrackState.error;
                  } else if (state is TrackStateSucees) {
                    //lay thong tin track
                    fetchState = FetchTrackState.success;

                    final track = state.trackModel.tracks.first;
                    setState(() {
                      trackList.add(track);
                    });

                    player.addAudioSource(
                      AudioSource.uri(Uri.parse(track.previewUrl)),
                    );
                  } else {
                    fetchState = FetchTrackState.none;
                  }
                },

                // buildWhen: (previous, current) {
                //   // Chỉ rebuild khi state thực sự thay đổi kiểu
                //   return current is TrackStateSucees ||
                //       current is TrackStateLoading ||
                //       current is TrackStateError;
                // },
                // builder: (context, state) {
                //   if (state is TrackStateLoading) {
                //     return const CircularProgressIndicator();
                //   }
                //   if (state is TrackStateError) {
                //     return const Text("lỗi");
                //   }
                //   if (state is TrackStateSucees) {
                //     //lay thong tin track

                //     final track = state.trackModel.tracks.first;
                //     trackList?.add(track);

                //     // curTrack = track;

                //     // final hasPreviewUrl =
                //     //     track.previewUrl != null && track.previewUrl.isNotEmpty;

                //     // return Column(
                //     //   children: [
                //     //     Text(track.name),
                //     //     if (!hasPreviewUrl) Text("track không có preview"),
                //     //   ],
                //     // );
                //   }
                //   return Text("lỗi");
                // },
                child: Expanded(
                  child:
                      trackList.isEmpty
                          ? CircularProgressIndicator()
                          : ListView.separated(
                            itemBuilder: (context, index) {
                              final track = trackList[index];

                              return trackItem(
                                track: track,
                                onTap: () async {
                                  curTrack = track;
                                  await _playTrack(index);
                                },
                              );
                            },
                            separatorBuilder:
                                (context, index) => 10.verticalSpace,
                            itemCount: trackList.length,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: widget.color,
    );
  }

  Future<void> _playTrack(int index) async {
    if (index < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("không tìm thấy bản preview")));
      return;
    }
    try {
      player.seek(Duration.zero, index: index);

      await player.play();
    } on PlayerException catch (e) {
      log(e.message!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("lỗi phát nhạc ")));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    context.read<TrackCubit>().fetchTrack("4WNcduiCmDNfmTEz7JvmLv");
    context.read<TrackCubit>().fetchTrack("0S1uRwIQF1AWR6gp4iXntl");
    context.read<TrackCubit>().fetchTrack("2L3R75fV5mZIGDVm3nDKqI");

    super.initState();
    player = AudioPlayer();
    _setupPlayerListeners();
  }

  void _setupPlayerListeners() {
    player.playerStateStream.listen((playerState) {
      setState(() {
        isPlaying = playerState.playing;
      });
    });

    player.durationStream.listen((duration) {
      setState(() => _duration = duration ?? Duration.zero);
    });

    player.positionStream.listen((position) {
      setState(() => _pos = position);
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

class trackItem extends StatelessWidget {
  const trackItem({super.key, required this.track, this.onTap});

  final Track? track;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Text(track!.name));
  }
}
