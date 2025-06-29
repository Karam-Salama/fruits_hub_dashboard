import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../add_user/domain/entities/user_entity.dart';

abstract class ShowUsersRepo {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, void>> deleteUser(String userId);
}
