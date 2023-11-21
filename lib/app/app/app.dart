import 'package:client/app/app/router.dart';
import 'package:client/app/app/session_expired_dialog.dart';
import 'package:client/app/app/session_forbidden_dialog.dart';
import 'package:client/app/app/theme.dart';
import 'package:client/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:requester/requester.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      if (exception is NotLoggedIn) {
        showSessionExpiredDialog(navigatorKey.currentContext!);
        return true;
      } else if (exception is Forbidden) {
        showForbiddenDialog(navigatorKey.currentContext!);
        return true;
      }
      return false;
    };

    return const MainView();
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'HW Dashboard',
      routerConfig: router,
      theme: theme,
    );
  }
}
