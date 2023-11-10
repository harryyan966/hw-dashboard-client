// ignore_for_file: avoid_dynamic_calls

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    log('''
    ${bloc.runtimeType}
    ${transition.currentState} ====(${transition.event.runtimeType})===> ${transition.nextState}
    ''');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('ERROR: (${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}

void bootstrap(Widget Function() builder) {
  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here

  runApp(builder());
}
