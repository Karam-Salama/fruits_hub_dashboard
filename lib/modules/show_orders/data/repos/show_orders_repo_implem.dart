import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';

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
  Stream<Either<Failure, List<OrderEntity>>> getOrders() async* {
    try {
      await for (var data
          in databaseService.streamData(path: BackendEndpoints.getOrders)) {
        List<OrderEntity> orders = (data as List)
            .map<OrderEntity>((e) => OrderModel.fromJson(e).toEntity())
            .toList();

        yield Right(orders);
      }
    } on Exception catch (e) {
      yield Left(ServerFailure('فشل في جلب الطلبات: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrders({
    required OrderStatusEnum status,
    required String orderId,
  }) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoints.updateOrder,
        documentId: orderId,
        data: {
          'status': status.name,
        },
      );
      return Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure('فشل في تحديث الطلبات: ${e.toString()}'));
    }
  }
}
