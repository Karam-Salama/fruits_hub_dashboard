import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/show_user_repo.dart';
import 'show_users_states.dart';

class ShowUsersCubit extends Cubit<ShowUsersStates> {
  ShowUsersCubit({required this.showUsersRepo}) : super(ShowUsersInitial());
  final ShowUsersRepo showUsersRepo;

  Future<void> getUsers() async {
    emit(ShowUsersLoadingState());
    final result = await showUsersRepo.getUsers();
    result.fold(
        (failure) => emit(ShowUsersErrorState(errorMessage: failure.message)),
        (users) => emit(ShowUsersSuccessState(users: users)));
  }
}
