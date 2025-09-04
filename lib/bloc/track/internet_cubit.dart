import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/track/internet_state.dart';
import 'package:music_app/data/constants/enum.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription _connectionSub;

  InternetCubit({required this.connectivity})
    : super(InternetState(ConnectionType.none));

  void checkConnectivity() async {
    var connectionResult = await Connectivity().checkConnectivity();
    _updateConnectivity(connectionResult);
  }

  void _updateConnectivity(List<ConnectivityResult> r) {
    ConnectivityResult result = r.first;

    if (result == ConnectivityResult.wifi) {
      emit(const InternetState(ConnectionType.wifi));
    } else if (result == ConnectivityResult.mobile) {
      emit(const InternetState(ConnectionType.data));
    } else if (result == ConnectivityResult.none) {
      emit(const InternetState(ConnectionType.none));
    }
  }

  void trackConnectivityChange() {
    _connectionSub = connectivity.onConnectivityChanged.listen((r) {
      _updateConnectivity(r);
    });
  }

  @override
  Future<void> close() {
    _connectionSub.cancel();
    return super.close();
  }
}
