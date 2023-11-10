part of 'clubs_bloc.dart';

enum HomeStatus { initial, loading, loaded }

class ClubsState extends Equatable {
  const ClubsState({
    this.status = HomeStatus.initial,
    this.errorMessage,
    this.currentUser,
  });

  final HomeStatus status;
  final String? errorMessage;
  final User? currentUser;

  @override
  List<Object?> get props => [status, errorMessage, currentUser];

  ClubsState copyWith({
    HomeStatus? status,
    String? Function()? errorMessage,
    User? Function()? currentUser,
  }) {
    return ClubsState(
      status: status ?? this.status,
      errorMessage: errorMessage == null ? this.errorMessage : errorMessage(),
      currentUser: currentUser == null ? this.currentUser : currentUser(),
    );
  }
}
