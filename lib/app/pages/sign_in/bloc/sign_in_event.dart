part of 'sign_in_bloc.dart';

sealed class SignInEvent {
  const SignInEvent();
}

class LoadPage extends SignInEvent {
  const LoadPage();
}

class SignIn extends SignInEvent {
  const SignIn({required this.userName, required this.password});

  final String userName;
  final String password;
}
