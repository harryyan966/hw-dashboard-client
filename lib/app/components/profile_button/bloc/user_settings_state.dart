part of 'user_settings_bloc.dart';

enum UserSettingsStatus { loading, loaded }

class UserSettingsState extends Equatable {
  const UserSettingsState({
    this.status = UserSettingsStatus.loading,
    this.profile,
  });

  final UserSettingsStatus status;
  final String? profile;

  @override
  List<Object?> get props => [status, profile];

  UserSettingsState copyWith({
    UserSettingsStatus? status,
    String? profile,
  }) {
    return UserSettingsState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }
}
