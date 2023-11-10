import 'package:bloc/bloc.dart';
import 'package:client_model_validators/client_model_validators.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc({
    required this.courseRepository,
  }) : super(const CoursesState()) {
    on<LoadPage>(_loadPage);
  }

  final CourseRepository courseRepository;

  Future<void> _loadPage(LoadPage event, Emitter<CoursesState> emit) async {
    print('LOAD PAGE');
    emit(state.copyWith(status: CourseStatus.loading));
    final courses = await courseRepository.readAll(amount: 10);
    emit(state.copyWith(status: CourseStatus.loaded, courses: courses));
  }
}
