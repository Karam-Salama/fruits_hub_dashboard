import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> addUser(
    String email,
    String password,
    String name,
  );

  Future addUserData({required UserEntity user});

  Future<void> verifyEmail();
}
