import 'package:bloc/bloc.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:requester/requester.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  UserSettingsBloc({
    required this.auth,
    required this.userRepository,
  }) : super(const UserSettingsState()) {
    on<ChangeProfileImage>(_changeAvatar);
  }

  final ClientAuth auth;
  final UserRepository userRepository;

  Future<void> _changeAvatar(ChangeProfileImage event, Emitter<UserSettingsState> emit) async {
    final user = await auth.getCurrentUser();
    if (user == null) {
      throw NotLoggedIn();
    }
    await userRepository.update(user.id, user.copyWith(profile: event.profile));
  }
}
