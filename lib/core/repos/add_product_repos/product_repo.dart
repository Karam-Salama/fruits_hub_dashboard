import 'package:dartz/dartz.dart';

import '../../../modules/add_product/domain/entities/product_entity.dart';
import '../../errors/failures.dart';

abstract class ProductRepo {
  Future<Either<Failure, void>> addProduct(ProductEntity addProductEntity);
}
