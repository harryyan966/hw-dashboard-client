part of 'courses_bloc.dart';

enum CoursesStatus { loading, loaded, error }

class CoursesState extends Equatable {
  const CoursesState({
    this.status = CoursesStatus.loading,
    this.errorMessage,
    this.courses,
    this.teachers,
    this.searchKeyword,
  });

  final CoursesStatus status;
  final String? errorMessage;
  final List<Course>? courses;
  final Map<String, User>? teachers; // maps courseid to teacher
  final String? searchKeyword;

  @override
  List<Object?> get props => [status, errorMessage, courses, teachers, searchKeyword];

  List<Course> get filteredCourses => searchKeyword == null || searchKeyword!.isEmpty
      ? courses!
      : courses!.where((Course course) {
          for (final field in course.searchedFields) {
            if (field.getValue(course).toLowerCase().contains(searchKeyword!.toLowerCase())) {
              return true;
            }
          }
          return false;
        }).toList();

  CoursesState copyWith({
    CoursesStatus? status,
    String? errorMessage,
    List<Course>? courses,
    Map<String, User>? teachers,
    String? searchKeyword,
  }) {
    return CoursesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      courses: courses ?? this.courses,
      teachers: teachers ?? this.teachers,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}
