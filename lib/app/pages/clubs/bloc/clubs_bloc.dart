import 'package:bloc/bloc.dart';
import 'package:client_auth/client_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'clubs_event.dart';
part 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubsEvent, ClubsState> {
  ClubsBloc({required this.clientAuth}) : super(const ClubsState()) {
    on<LoadPage>(_loadPage);
  }

  final ClientAuth clientAuth;

  Future<void> _loadPage(LoadPage event, Emitter<ClubsState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final user = await clientAuth.getCurrentUser();
    emit(state.copyWith(status: HomeStatus.loaded, currentUser: () => user));
  }
}
