import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showSessionExpiredDialog(BuildContext context) => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Session Expired'),
        content: const Text(
          "Sorry, you've logged in for too long, please log in again.",
        ),
        actions: [
          FilledButton(
            onPressed: () => context.goNamed('signIn'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
