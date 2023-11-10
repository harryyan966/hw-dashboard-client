part of 'courses_bloc.dart';

sealed class CoursesEvent {
  const CoursesEvent();
}

class LoadPage extends CoursesEvent {
  const LoadPage();
}

class LoadMoreCourses extends CoursesEvent {
  const LoadMoreCourses({required this.amount});

  final int amount;
}

class SearchCourses extends CoursesEvent {
  const SearchCourses({required this.keyword});

  final String keyword;
}
