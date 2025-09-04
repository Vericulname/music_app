import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/app/track_cubit.dart';
import 'package:music_app/presentation/homeScreen.dart';
import 'package:music_app/presentation/menu.dart';

class Approute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(color: Colors.green),
        );

      case '/menu':
        return MaterialPageRoute(
          builder: (_) => MenuScreen(color: Colors.purple),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("no route"))),
        );
    }
  }
}
