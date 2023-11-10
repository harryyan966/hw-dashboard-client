part of 'course_detail_bloc.dart';

enum CourseDetailStatus { initial, loading, loaded, error }

class CourseDetailState extends Equatable {
  const CourseDetailState({
    this.status = CourseDetailStatus.initial,
    this.errorMessage,
    this.course,
  });

  final CourseDetailStatus status;
  final String? errorMessage;
  final Course? course;

  @override
  List<Object?> get props => [status, errorMessage, course];

  CourseDetailState copyWith({
    CourseDetailStatus? status,
    String? errorMessage,
    Course? Function()? course,
  }) {
    return CourseDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      course: course == null ? this.course : course(),
    );
  }
}
