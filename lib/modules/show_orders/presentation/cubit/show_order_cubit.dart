import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/show_orders_repo.dart';
import 'show_order_states.dart';

class ShowOrdersCubit extends Cubit<ShowOrdersState> {
  ShowOrdersCubit({required this.showOrdersRepo}) : super(ShowOrdersInitial());

  final ShowOrdersRepo showOrdersRepo;
  StreamSubscription? _streamSubscription;

  void getOrders() async {
    emit(ShowOrdersLoading());
    _streamSubscription = showOrdersRepo.getOrders().listen((result) {
      result.fold(
        (failure) => emit(ShowOrdersFailure(errorMessage: failure.message)),
        (orders) => emit(ShowOrdersSuccess(orders: orders)),
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
