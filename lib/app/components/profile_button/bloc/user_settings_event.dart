part of 'user_settings_bloc.dart';

sealed class UserSettingsEvent {
  const UserSettingsEvent();
}

class ChangeProfileImage extends UserSettingsEvent {
  const ChangeProfileImage({required this.profile});

  final String profile;
}
