import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:fruits_hub_dashboard/core/errors/failures.dart';

import '../../services/storage_service.dart';
import '../../utils/app_Backend_Endpoints.dart';
import 'images_repo.dart';

class ImagesRepoImplementation implements ImagesRepo {
  final StorageService storageService;
  ImagesRepoImplementation(this.storageService);
  
  @override
  Future<Either<Failure, String>> uploadImage(File imageFile) async {
    try {
      String url =
        await storageService.uploadImage(imageFile, BackendEndpoints.images);
      return Right(url);
    } catch (e) {
      return Left(ServerFailure('Failed to upload image'));
    }
  }
}
