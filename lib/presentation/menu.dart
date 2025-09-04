// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/bloc/app/track_state.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  _MenuScreen createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // BlocConsumer<TrackCubit, TrackState>(
            //   listener: (context, state) {
            //     if (state.IsIncreased == true) {
            //       ScaffoldMessenger.of(
            //         context,
            //       ).showSnackBar(SnackBar(content: Text("tang")));
            //     } else {
            //       ScaffoldMessenger.of(
            //         context,
            //       ).showSnackBar(SnackBar(content: Text("giam")));
            //     }
            //   },
            //   builder: (context, state) {
            //     return Text(state.Value.toString());
            //   },
            // ),
          ],
        ),
      ),
      backgroundColor: widget.color,
    );
  }
}
