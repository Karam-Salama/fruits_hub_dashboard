import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../add_user/domain/entities/user_entity.dart';
import '../../domain/repo/show_user_repo.dart';
import 'show_users_states.dart';

class ShowUsersCubit extends Cubit<ShowUsersStates> {
  final ShowUsersRepo showUsersRepo;
  List<UserEntity> currentUsers = [];

  ShowUsersCubit({required this.showUsersRepo}) : super(ShowUsersInitial());
  StreamSubscription? _streamSubscription;
  void getUsers() async {
    emit(ShowUsersLoadingState());
    _streamSubscription = showUsersRepo.getUsers().listen((result) {
      result.fold(
        (failure) => emit(ShowUsersErrorState(errorMessage: failure.message)),
        (users) {
          currentUsers = users; // حفظ القائمة الحالية
          emit(ShowUsersSuccessState(users: users));
        },
      );
    });
  }

  Future<void> deleteUser(String userId) async {
    final usersBeforeDelete = List<UserEntity>.from(currentUsers);
    emit(DeleteUsersLoadingState());

    final result = await showUsersRepo.deleteUser(userId);
    result.fold(
      (failure) {
        emit(DeleteUsersErrorState(errorMessage: failure.message));
        emit(ShowUsersSuccessState(
            users: usersBeforeDelete)); // استعادة النسخة الاحتياطية
      },
      (_) {
        currentUsers.removeWhere((user) => user.uId == userId);
        emit(DeleteUsersSuccessState());
        emit(ShowUsersSuccessState(users: currentUsers));
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
