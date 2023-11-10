import 'package:client/app/pages/_.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'signIn',
      path: '/signIn',
      builder: (context, state) => const SignInPage(),
    ),
    
    /*GoRoute(
      name: 'clubs',
      path: '/clubs',
      builder: (context, state) => const ClubsPage(),
    ),
    GoRoute(
      name: 'casino',
      path: '/casino',
      builder: (context, state) => const CasinoPage(),
    ),*/

    GoRoute(
      name: 'courses',
      path: '/courses',
      builder: (context, state) => const CoursesPage(),
    ),
    GoRoute(
      name: 'courseDetail',
      path: '/courseDetail/:courseID',
      builder: (context, state) => CourseDetailPage(
        courseID: state.pathParameters['courseID'],
      ),
    ),

    /*
    GoRoute(
      name: 'blogs',
      path: '/blogs',
      builder: (context, state) => const GeneralBlogsPage(),
    ),
    GoRoute(
      name: 'homerooms',
      path: '/homerooms',
      builder: (context, state) => const HomeroomsPage(),
    ),
    GoRoute(
      name: 'homeroomDetail',
      path: '/homeroomDetail',
      builder: (context, state) => const HomeroomDetailPage(),
    ),
    */

    // GoRoute(
    //   name: 'collegeAppBlog',
    //   path: '/collegeAppBlog',
    //   builder: (context, state) => const CollegeApplicationBlogPage(),
    // ),
  ],
);
