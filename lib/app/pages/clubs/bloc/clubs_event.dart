part of 'clubs_bloc.dart';

sealed class ClubsEvent {
  const ClubsEvent();
}

class LoadPage extends ClubsEvent {
  const LoadPage();
}
