import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({this.errorMessage, super.key});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          errorMessage ?? 'An Error Occurred',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
    );
  }
}
