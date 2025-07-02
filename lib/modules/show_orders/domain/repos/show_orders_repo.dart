import 'package:dartz/dartz.dart';

import '../../../../core/enums/order_enum.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class ShowOrdersRepo {
  Stream<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, void>> updateOrders(
      {required OrderStatusEnum status, required String orderId});
}
