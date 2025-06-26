import '../../../add_user/domain/entities/user_entity.dart';

class ShowUsersStates {}

final class ShowUsersInitial extends ShowUsersStates {}

final class ShowUsersLoadingState extends ShowUsersStates {}

final class ShowUsersSuccessState extends ShowUsersStates {
  final List<UserEntity> users;
  ShowUsersSuccessState({required this.users});
}

final class ShowUsersErrorState extends ShowUsersStates {
  final String errorMessage;
  ShowUsersErrorState({required this.errorMessage});
}
