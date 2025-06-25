import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:fruits_hub_dashboard/core/errors/failures.dart';

import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/service_firebase_auth.dart';
import '../../../../core/utils/app_Backend_Endpoints.dart';
import '../../domain/repo/auth_repo.dart';
import "package:firebase_auth/firebase_auth.dart";

import '../models/user_model.dart';

class AuthRepoImplement extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImplement({
    required this.databaseService,
    required this.firebaseAuthService,
  });

  @override
  Future<Either<Failure, UserEntity>> addUser(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
      await verifyEmail();
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      log('Exception in AuthRepoImplementation.createUserWithEmailAndPassword method:  ${e.toString()}');
      return Left(ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    try {
      await databaseService.addData(
        path: BackendEndpoints.addUserData,
        data: UserModel.fromEntity(user).toMap(),
        documentId: user.uId,
      );
    } on CustomException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      log('Exception in AuthRepoImplementation.addUserData method: ${e.toString()}');
      throw ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  @override
  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  // Helper method to handle failed sign-in attempts
  Future<void> _handleSignInFailure(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }
}
