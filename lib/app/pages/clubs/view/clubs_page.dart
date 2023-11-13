import 'package:client/app/pages/clubs/bloc/clubs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClubsBloc(clientAuth: context.read()),
      child: const ClubsView(),
    );
  }
}

class ClubsView extends StatelessWidget {
  const ClubsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
