import 'package:client/app/app/app.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.clientAuth,
    required this.userRepository,
    required this.courseRepository,
    super.key,
  });

  final ClientAuth clientAuth;
  final UserRepository userRepository;
  final CourseRepository courseRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: clientAuth),
        RepositoryProvider.value(value: userRepository),
        RepositoryProvider.value(value: courseRepository),
      ],
      child: const AppView(),
    );
  }
}
