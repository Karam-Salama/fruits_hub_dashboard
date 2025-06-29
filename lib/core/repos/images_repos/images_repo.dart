import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';

abstract class ImagesRepo {
  Future<Either<Failure, String>> uploadImage(Object imageFile);
}
