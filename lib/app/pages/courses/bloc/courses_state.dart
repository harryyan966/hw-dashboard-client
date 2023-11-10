part of 'courses_bloc.dart';

enum CourseStatus { initial, loading, loaded }

class CoursesState extends Equatable {
  const CoursesState({
    this.status = CourseStatus.initial,
    this.errorMessage,
    this.courses,
    this.searchKeyword,
  });

  final CourseStatus status;
  final String? errorMessage;
  final List<Course>? courses;
  final String? searchKeyword;

  @override
  List<Object?> get props => [status, errorMessage, courses, searchKeyword];

  List<Course> get filteredCourses => searchKeyword == null || searchKeyword!.isEmpty
      ? courses!
      : courses!.where((Course course) {
          for (final field in course.searchedFields) {
            if (field.getValue(course).contains(searchKeyword!)) {
              return true;
            }
          }
          return false;
        }).toList();

  CoursesState copyWith({
    CourseStatus? status,
    String? errorMessage,
    List<Course>? courses,
    String? searchKeyword,
  }) {
    return CoursesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      courses: courses ?? this.courses,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}
