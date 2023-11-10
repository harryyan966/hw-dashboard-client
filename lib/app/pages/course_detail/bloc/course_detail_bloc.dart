import 'package:bloc/bloc.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc({
    required this.courseRepository,
  }) : super(const CourseDetailState()) {
    on<LoadPage>(_loadPage);
  }

  final CourseRepository courseRepository;

  Future<void> _loadPage(LoadPage event, Emitter<CourseDetailState> emit) async {
    emit(state.copyWith(status: CourseDetailStatus.loading));
    if (event.courseID == null) {
      emit(state.copyWith(status: CourseDetailStatus.error, errorMessage: 'No course id is provided'));
    } else {
      final course = await courseRepository.read(event.courseID!);
      emit(state.copyWith(status: CourseDetailStatus.loaded, course: () => course));
    }
  }
}
