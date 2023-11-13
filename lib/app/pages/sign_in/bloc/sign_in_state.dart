part of 'sign_in_bloc.dart';

enum SignInStatus { loading, loaded, error, signedIn }

class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.loading,
    this.errorMessage,
  });

  final SignInStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];

  SignInState copyWith({
    SignInStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
