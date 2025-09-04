import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/bloc/app/track_state.dart';

import 'package:music_app/data/constants/string.dart';
import 'package:music_app/data/model/track_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocBuilder<TrackCubit, TrackState>(
              builder: (context, state) {
                if (state is TrackStateLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is TrackStateError) {
                  return const Text("lỗi");
                }
                if (state is TrackStateSucees) {
                  List<Track> track = state.trackModel.tracks;

                  return track.first.name.isEmpty
                      ? Text("tên trống")
                      : Center(
                        child: Column(
                          children: [
                            Image.asset(dics, width: 300, height: 300),
                            10.verticalSpace,
                            Text(track.first.name),
                            40.verticalSpace,
                            Row(
                              children: [
                                Icon(Icons.replay_10),
                                10.horizontalSpace,
                                MaterialButton(
                                  child: Icon(Icons.play_arrow),
                                  onPressed: () {},
                                ),
                                10.horizontalSpace,
                                Icon(Icons.forward_10),
                              ],
                            ),
                          ],
                        ),
                      );
                }
                return SizedBox();
              },
            ),

            //BlocBuilder co the bi build nhieu lan
            MaterialButton(
              color: Colors.blue,
              child: Text("lấy ng dùng"),
              onPressed: () => context.read<TrackCubit>().fetchTrack(),
            ),
          ],
        ),
      ),
      backgroundColor: widget.color,
    );
  }
}
