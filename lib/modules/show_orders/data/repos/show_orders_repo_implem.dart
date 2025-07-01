import 'package:dartz/dartz.dart';

import 'package:fruits_hub_dashboard/core/errors/failures.dart';
import 'package:fruits_hub_dashboard/core/services/database_service.dart';

import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_entity.dart';

import '../../../../core/utils/app_Backend_Endpoints.dart';
import '../../domain/repos/show_orders_repo.dart';
import '../models/order_model.dart';

class ShowOrdersRepoImplem implements ShowOrdersRepo {
  final DatabaseService databaseService;

  ShowOrdersRepoImplem({required this.databaseService});
  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      var response =
          await databaseService.getData(path: BackendEndpoints.getOrders);
      List<OrderEntity> orders = (response as List)
          .map<OrderEntity>((e) => OrderModel.fromJson(e).toEntity())
          .toList();

      return Right(orders);
    } on Exception catch (e) {
      return Left(ServerFailure('فشل في جلب الطلبات: ${e.toString()}'));
    }
  }
}
