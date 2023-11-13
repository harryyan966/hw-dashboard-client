import 'package:bloc/bloc.dart';
import 'package:client_auth/client_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:requester/requester.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required this.clientAuth,
  }) : super(const SignInState()) {
    on<LoadPage>(_loadPage);
    on<SignIn>(_signIn);
  }

  final ClientAuth clientAuth;

  Future<void> _loadPage(LoadPage event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: SignInStatus.loaded));
  }

  Future<void> _signIn(SignIn event, Emitter<SignInState> emit) async {
    try {
      await clientAuth.signIn(event.username, event.password);
      emit(state.copyWith(status: SignInStatus.signedIn));
    } on NotFound {
      emit(
        state.copyWith(
          status: SignInStatus.error,
          errorMessage: 'The username-password combination is incorrect.',
        ),
      );
    }
  }
}
