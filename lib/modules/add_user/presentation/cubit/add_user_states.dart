import '../../domain/entities/user_entity.dart';

class AddUserState {}

final class AddUserInitial extends AddUserState {}

final class AddUserLoadingState extends AddUserState {}

final class AddUserSuccessState extends AddUserState {
  final UserEntity userEntity;
  AddUserSuccessState({required this.userEntity});
}

final class AddUserErrorState extends AddUserState {
  final String errorMessage;
  AddUserErrorState({required this.errorMessage});
}

final class ObscurePasswordTextUpdateState extends AddUserState {}
