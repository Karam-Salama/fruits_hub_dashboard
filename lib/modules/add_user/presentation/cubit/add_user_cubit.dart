import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repo/auth_repo.dart';
import 'add_user_states.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit({required this.authRepo}) : super(AddUserInitial());
  String? name;
  String? emailAddress;
  String? password;
  GlobalKey<FormState> addUserFormKey = GlobalKey<FormState>();
  AutovalidateMode addUserAutoValidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = false;

  final AuthRepo authRepo;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ObscurePasswordTextUpdateState());
  }

  Future<void> addUser(String email, String password, String name) async {
    emit(AddUserLoadingState());
    final result = await authRepo.addUser(email, password, name);
    result.fold(
      (failure) => emit(AddUserErrorState(errorMessage: failure.message)),
      (userEntity) => emit(AddUserSuccessState(userEntity: userEntity)),
    );
  }
}
