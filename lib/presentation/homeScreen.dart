import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/bloc/app/track_state.dart';

import 'package:music_app/data/constants/string.dart';
import 'package:music_app/data/model/track_model.dart';
import 'package:music_app/presentation/wiget/customButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    bool isPlaying = true;
    late final AudioPlayer player = AudioPlayer();
    late final AudioSource source;
    // Duration _duration = const Duration();
    // Duration _pos = const Duration();

    Track track;

    context.read<TrackCubit>().fetchTrack();

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

              BlocBuilder<TrackCubit, TrackState>(
                builder: (context, state) {
                  if (state is TrackStateLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is TrackStateError) {
                    return const Text("lỗi");
                  }
                  if (state is TrackStateSucees) {
                    //lay thong tin track
                    track = state.trackModel.tracks.first;

                    try {
                      source = AudioSource.uri(Uri.parse(track.previewUrl));
                      player.setAudioSource(source);

                      // _pos = player.playbackEvent.updatePosition;
                    } on PlayerException catch (e) {
                      log(e.message!);
                    }

                    return track.name.isEmpty
                        ? Text("tên trống")
                        : Text(track.name);
                  }
                  return Text("lỗi");
                },
              ),
              40.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    icons: Icons.replay_10,
                    onPressed: () {
                      // player.seek(Duration(seconds: _pos.inSeconds - 10));
                    },
                  ),
                  // 10.horizontalSpace,
                  CustomButton(
                    icons: isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: () {
                      if (isPlaying) {
                        player.play();
                      } else {
                        player.stop();
                      }
                      isPlaying = !isPlaying;
                    },
                  ),
                  // 10.horizontalSpace,
                  CustomButton(
                    icons: Icons.forward_10,
                    onPressed: () {
                      // player.seek(Duration(seconds: _pos.inSeconds + 10));
                    },
                  ),
                ],
              ),
              // Slider(
              //   value: _pos.inSeconds.toDouble(),

              //   onChanged: (val) async {
              //     await player.seek(Duration(seconds: val.toInt()));
              //   },
              //   min: 0,
              //   max: _duration.inSeconds.toDouble(),
              // ),
              // Expanded(
              //   child: ListView.separated(
              //     itemBuilder: itemBuilder,
              //     separatorBuilder: separatorBuilder,
              //     itemCount: itemCount,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      backgroundColor: color,
    );
  }
}
