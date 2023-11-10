import 'package:client/app/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(clientAuth: context.read())..add(const LoadPage()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('HOME', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: Space.space24),
            ElevatedButton(
              onPressed: () {
                context.goNamed('courses');
              },
              child: const Text('COURSES'),
            )
          ],
        ),
      ),
    );
  }
}
