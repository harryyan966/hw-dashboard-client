import 'dart:async';

import 'package:client/app/app.dart';
import 'package:client/bootstrap.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:flutter/material.dart';

// Future<void> main() async {
//   runZonedGuarded(() {
//     WidgetsFlutterBinding.ensureInitialized();

//     FlutterError.onError = (FlutterErrorDetails errorDetails) {
//       print('This is an error on the Flutter SDK');
//       print(errorDetails.exception);
//       print('-----');
//       // print(errorDetails.stack);
//     };

//     final clientAuth = MockClientAuth();

//     const userRepository = MockUserRepository();
//     const courseRepository = MockCourseRepository();

//     runApp(
//       App(
//         clientAuth: clientAuth,
//         userRepository: userRepository,
//         courseRepository: courseRepository,
//       ),
//     );
//   }, (error, stackTrace) {
//     print('This is a pure Dart error');
//     print(error);
//     print('-----');
//     // print(stackTrace);
//   });
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // const flutterSecureStorage = FlutterSecureStorage();
  // const tokenCacher = TokenCacher(secureCacher: SecureCacher(storage: flutterSecureStorage));
  // final requester = Requester(baseURL: 'https://127.0.0.1', tokenCacher: tokenCacher);

  final clientAuth = MockClientAuth();

  const userRepository = MockUserRepository();
  const courseRepository = MockCourseRepository();

  bootstrap(
    () => App(
      clientAuth: clientAuth,
      userRepository: userRepository,
      courseRepository: courseRepository,
    ),
  );
}
