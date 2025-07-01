import 'package:flutter/material.dart';

import '../../domain/entities/order_entity.dart';

@immutable
sealed class ShowOrdersState {}

final class ShowOrdersInitial extends ShowOrdersState {}

final class ShowOrdersLoading extends ShowOrdersState {}

final class ShowOrdersFailure extends ShowOrdersState {
  final String errorMessage;
  ShowOrdersFailure({required this.errorMessage});
}

final class ShowOrdersSuccess extends ShowOrdersState {
  final List<OrderEntity> orders;
  ShowOrdersSuccess({required this.orders});
}
