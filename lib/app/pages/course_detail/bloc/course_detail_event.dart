part of 'course_detail_bloc.dart';

sealed class CourseDetailEvent {
  const CourseDetailEvent();
}

class LoadPage extends CourseDetailEvent {
  const LoadPage({required this.courseID});

  final String? courseID;
}
