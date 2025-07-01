import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/show_products_repo.dart';
import 'show_products_states.dart';

class ShowProductsCubit extends Cubit<ShowProductsState> {
  ShowProductsCubit(this.showProductsRepo) : super(ShowProductsInitial());

  final ShowProductsRepo showProductsRepo;
  StreamSubscription? _streamSubscription;

  void getProducts() async {
    emit(ShowProductsLoading());
    _streamSubscription = showProductsRepo.getProducts().listen((result) {
      result.fold(
        (failure) => emit(ShowProductsFailure(errorMessage: failure.message)),
        (products) => emit(ShowProductsSuccess(products: products)),
      );
    });
  }

  Future<void> deleteProduct(String code) async {
    emit(DeleteProductLoadingState());
    final result = await showProductsRepo.deleteProduct(code);
    result.fold(
      (failure) => emit(DeleteProductErrorState(errorMessage: failure.message)),
      (_) => getProducts(),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
