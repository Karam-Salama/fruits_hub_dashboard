import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/modules/add_user/data/models/user_model.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/app_Backend_Endpoints.dart';
import '../../../add_user/domain/entities/user_entity.dart';
import '../../domain/repo/show_user_repo.dart';

class ShowUsersRepoImplement extends ShowUsersRepo {
  final DatabaseService databaseService;

  ShowUsersRepoImplement({
    required this.databaseService,
  });

  @override
  Stream<Either<Failure, List<UserEntity>>> getUsers() async* {
    try {
      await for (var data
          in databaseService.streamData(path: BackendEndpoints.getUserData)) {
        List<UserEntity> users = (data as List)
            .map<UserEntity>((e) => UserModel.fromJson(e).toEntity())
            .toList();

        yield Right(users);
      }
    } catch (e) {
      yield left(ServerFailure('فشل في جلب المستخدمين: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      // 1. حذف المستند المراد حذفه من مجموعة "users"
      await FirebaseFirestore.instance
          .collection(BackendEndpoints.getUserData)
          .doc(userId)
          .delete();

      return right(null);
    } catch (e) {
      return left(ServerFailure('فشل في حذف المستخدم: ${e.toString()}'));
    }
  }
}
