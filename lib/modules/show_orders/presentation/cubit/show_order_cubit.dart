import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/show_orders_repo.dart';
import 'show_order_states.dart';

class ShowOrdersCubit extends Cubit<ShowOrdersState> {
  ShowOrdersCubit({required this.showOrdersRepo}) : super(ShowOrdersInitial());

  final ShowOrdersRepo showOrdersRepo;

  Future<void> getOrders() async {
    emit(ShowOrdersLoading());
    final result = await showOrdersRepo.getOrders();
    result.fold(
      (failure) => emit(ShowOrdersFailure(errorMessage: failure.message)),
      (orders) => emit(ShowOrdersSuccess(orders: orders)),
    );
  }
}
