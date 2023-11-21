import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showForbiddenDialog(BuildContext context) => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'Sorry, you do not have the permissions to enter this page.',
        ),
        actions: [
          FilledButton(
            onPressed: () => context.goNamed('home'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
