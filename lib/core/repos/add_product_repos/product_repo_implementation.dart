import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/modules/add_product/data/models/product_model.dart';
import 'package:fruits_hub_dashboard/modules/add_product/domain/entities/product_entity.dart';

import '../../errors/failures.dart';
import '../../services/database_service.dart';
import '../../utils/app_Backend_Endpoints.dart';
import 'product_repo.dart';

class ProductRepoImplementation implements ProductRepo {
  final DatabaseService databaseService;

  ProductRepoImplementation(this.databaseService);

  @override
  Future<Either<Failure, void>> addProduct(
      ProductEntity addProductEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoints.addProduct,
        data: ProductModel.fromEntity(addProductEntity).toJson(),
        documentId: addProductEntity.code,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add product'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(
      ProductEntity updateProductEntity) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoints.addProduct,
        data: ProductModel.fromEntity(updateProductEntity).toJson(),
        documentId:
            updateProductEntity.code, // استخدام كود المنتج كـ documentId
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update product: ${e.toString()}'));
    }
  }
}
