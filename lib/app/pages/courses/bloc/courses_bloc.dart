import 'package:bloc/bloc.dart';
import 'package:client_model_validators/client_model_validators.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc({
    required this.userRepository,
    required this.courseRepository,
  }) : super(const CoursesState()) {
    on<LoadPage>(_loadPage);
    on<SearchCourses>(_searchCourses);
  }

  final UserRepository userRepository;
  final CourseRepository courseRepository;

  Future<void> _loadPage(LoadPage event, Emitter<CoursesState> emit) async {
    // start loading
    emit(state.copyWith(status: CoursesStatus.loading));

    // get courses
    final courses = await courseRepository.readAll(amount: 10);

    // get teachers based on the teacher ids provided
    final teachers = <String, User>{};
    for (final course in courses) {
      final teacher = await userRepository.read(course.teacherID);
      if (teacher == null) {
        emit(state.copyWith(status: CoursesStatus.error, errorMessage: 'Some teacher id is not valid'));
      } else {
        teachers[course.id] = teacher;
      }
    }

    // emit data
    emit(state.copyWith(status: CoursesStatus.loaded, courses: courses, teachers: teachers));
  }

  void _searchCourses(SearchCourses event, Emitter<CoursesState> emit) {
    emit(state.copyWith(status: CoursesStatus.loaded, searchKeyword: event.keyword));
  }
}
