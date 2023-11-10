import 'package:bloc/bloc.dart';
import 'package:client_auth/client_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:hwdb_models/hwdb_models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.clientAuth,
  }) : super(const HomeState()) {
    on<LoadPage>(_loadPage);
  }

  final ClientAuth clientAuth;

  Future<void> _loadPage(LoadPage event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final user = await clientAuth.getCurrentUser();
    emit(state.copyWith(status: HomeStatus.loaded, currentUser: () => user));
  }
}
