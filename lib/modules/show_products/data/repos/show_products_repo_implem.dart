import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:fruits_hub_dashboard/core/errors/failures.dart';

import 'package:fruits_hub_dashboard/modules/add_product/domain/entities/product_entity.dart';

import '../../../../core/services/database_service.dart';
import '../../../../core/utils/app_Backend_Endpoints.dart';
import '../../../add_product/data/models/product_model.dart';
import '../../domain/repos/show_products_repo.dart';

class ShowProductsRepoImplem implements ShowProductsRepo {
  final DatabaseService databaseService;

  ShowProductsRepoImplem({required this.databaseService});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection(BackendEndpoints.getProducts)
          .get();

      List<ProductEntity> products = data.docs
          .map((doc) => ProductModel.fromJson(doc.data()).toEntity())
          .toList();
      ;
      return right(products);
    } catch (e) {
      return left(ServerFailure('Failed to get products ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String code) async {
    try {
      await FirebaseFirestore.instance
          .collection(BackendEndpoints.getProducts)
          .where('code', isEqualTo: code)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });

      return right(null);
    } catch (e) {
      return left(ServerFailure('فشل في حذف المنتج: ${e.toString()}'));
    }
  }
}
