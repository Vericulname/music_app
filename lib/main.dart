import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/bloc/track/internet_cubit.dart';
import 'package:music_app/data/provider/track_provider.dart';
import 'package:music_app/data/repository/track_repos.dart';
import 'package:music_app/presentation/routes/AppRoute.dart';

import 'package:music_app/presentation/homeScreen.dart';
import 'package:music_app/presentation/menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Connectivity connectivity = Connectivity();
  final Approute _appRoute = Approute();

  @override
  Widget build(BuildContext context) {
    //cung cap cubit/bloc cho cac wiget con
    return ScreenUtilInit(
      builder:
          (context, child) => RepositoryProvider(
            create: (context) => TrackRepos(Trackprovider()),

            child: BlocProvider<TrackCubit>(
              create: (context) => TrackCubit(context.read<TrackRepos>()),
              child: MaterialApp(
                home: HomeScreen(color: Colors.white),
                onGenerateRoute: _appRoute.onGenerateRoute,
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
