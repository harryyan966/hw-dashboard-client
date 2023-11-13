part of 'course_detail_bloc.dart';

enum CourseDetailStatus { loading, loaded, error }

class CourseDetailState extends Equatable {
  const CourseDetailState({
    this.status = CourseDetailStatus.loading,
    this.errorMessage,
    this.course,
    this.assignments,
    this.selectedAssignment,
  });

  final CourseDetailStatus status;
  final String? errorMessage;
  final Course? course;
  final List<Assignment>? assignments;
  final Assignment? selectedAssignment;

  @override
  List<Object?> get props => [status, errorMessage, course, assignments, selectedAssignment];

  CourseDetailState copyWith({
    CourseDetailStatus? status,
    String? errorMessage,
    Course? Function()? course,
    List<Assignment>? assignments,
    Assignment? selectedAssignment,
  }) {
    return CourseDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      course: course == null ? this.course : course(),
      assignments: assignments ?? this.assignments,
      selectedAssignment: selectedAssignment ?? this.selectedAssignment,
    );
  }
}
