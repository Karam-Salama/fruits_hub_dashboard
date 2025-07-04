import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AddUserRepo {
  Future<Either<Failure, UserEntity>> addUser(
    String email,
    String password,
    String name,
  );

  Future addUserData({required UserEntity user});

  Future<Either<Failure, void>> updateUser({required UserEntity user});

  Future<void> verifyEmail();
}
