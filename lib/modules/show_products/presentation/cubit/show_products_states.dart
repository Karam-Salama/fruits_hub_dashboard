import 'package:flutter/material.dart';

import '../../../add_product/domain/entities/product_entity.dart';

@immutable
sealed class ShowProductsState {}

final class ShowProductsInitial extends ShowProductsState {}

final class ShowProductsLoading extends ShowProductsState {}

final class ShowProductsFailure extends ShowProductsState {
  final String errorMessage;
  ShowProductsFailure({required this.errorMessage});
}

final class ShowProductsSuccess extends ShowProductsState {
  final List<ProductEntity> products;
  ShowProductsSuccess({required this.products});
}

final class DeleteProductLoadingState extends ShowProductsState {}

final class DeleteProductSuccessState extends ShowProductsState {}

final class DeleteProductErrorState extends ShowProductsState {
  final String errorMessage;
  DeleteProductErrorState({required this.errorMessage});
}
