import 'package:flutter/material.dart';

@immutable
sealed class UpdateOrdersState {}

final class UpdateOrdersInitial extends UpdateOrdersState {}

final class UpdateOrdersLoading extends UpdateOrdersState {}

final class UpdateOrdersFailure extends UpdateOrdersState {
  final String errorMessage;
  UpdateOrdersFailure({required this.errorMessage});
}

final class UpdateOrdersSuccess extends UpdateOrdersState {}
