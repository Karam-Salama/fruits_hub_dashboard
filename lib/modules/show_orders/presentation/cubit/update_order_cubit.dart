import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/order_enum.dart';
import '../../domain/repos/show_orders_repo.dart';
import 'update_order_states.dart';

class UpdateOrderCubit extends Cubit<UpdateOrdersState> {
  UpdateOrderCubit({required this.showOrdersRepo})
      : super(UpdateOrdersInitial());

  final ShowOrdersRepo showOrdersRepo;

  Future<void> updateOrderStatus({
    required OrderStatusEnum status,
    required String orderId,
  }) async {
    emit(UpdateOrdersLoading());
    var result =
        await showOrdersRepo.updateOrders(status: status, orderId: orderId);
    result.fold(
      (failure) => emit(UpdateOrdersFailure(errorMessage: failure.message)),
      (_) => emit(UpdateOrdersSuccess()),
    );
  }
}
