import 'package:client/app/pages/course_detail/bloc/course_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({required this.courseID, super.key});

  final String? courseID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailBloc(courseRepository: context.read())..add(LoadPage(courseID: courseID)),
      child: const CourseDetailView(),
    );
  }
}

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
