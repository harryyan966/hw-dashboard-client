part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class LoadPage extends HomeEvent {
  const LoadPage();
}
