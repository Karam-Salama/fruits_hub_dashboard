import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../add_product/domain/entities/product_entity.dart';

abstract class ShowProductsRepo {
  Stream<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, void>> deleteProduct(String code);
}
