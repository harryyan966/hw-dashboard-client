import 'package:bloc/bloc.dart';
import 'package:client_repositories/client_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc({
    required this.courseRepository,
    // required this.scoreRepository
  }) : super(const CourseDetailState()) {
    on<LoadPage>(_loadPage);
    on<SelectAssignment>(_selectAssignment);
  }

  final CourseRepository courseRepository;
  // final ScoreRepository scoreRepository;

  Future<void> _loadPage(LoadPage event, Emitter<CourseDetailState> emit) async {
    emit(state.copyWith(status: CourseDetailStatus.loading));
    if (event.courseID == null) {
      emit(state.copyWith(status: CourseDetailStatus.error, errorMessage: 'No course id is provided'));
      return;
    }
    final course = await courseRepository.getByID(event.courseID!);
    final assignments = [
      for (int i = 0; i < 10; i++)
        Assignment(
          id: 'assignment$i',
          name: 'Assignment $i',
          type: AssignmentType.finalExam,
          description:
              '''
assignment description 
    ];

    emit(state.copyWith(status: CourseDetailStatus.loaded, course: () => course, assignments: assignments));
  }

  Future<void> _selectAssignment(SelectAssignment event, Emitter<CourseDetailState> emit) async {
    emit(state.copyWith(status: CourseDetailStatus.loaded, selectedAssignment: event.assignment));
  }
}
''',
          dueDate: DateTime.now(),
        ),
    ];

    emit(state.copyWith(status: CourseDetailStatus.loaded, course: () => course, assignments: assignments));
  }

  Future<void> _selectAssignment(SelectAssignment event, Emitter<CourseDetailState> emit) async {
    emit(state.copyWith(status: CourseDetailStatus.loaded, selectedAssignment: event.assignment));
  }
}
