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
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add product'));
    }
  }
}
