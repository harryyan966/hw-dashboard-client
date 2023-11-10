part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.errorMessage,
    this.currentUser,
  });

  final HomeStatus status;
  final String? errorMessage;
  final User? currentUser;

  @override
  List<Object?> get props => [status, errorMessage, currentUser];

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    User? Function()? currentUser,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser == null ? this.currentUser : currentUser(),
    );
  }
}
