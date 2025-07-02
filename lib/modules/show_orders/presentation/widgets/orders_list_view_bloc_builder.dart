import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/functions/get_dummy_orders.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../cubit/show_order_cubit.dart';
import '../cubit/show_order_states.dart';
import 'order_items_list_view.dart';

class OrdersListViewBlocBuilder extends StatelessWidget {
  const OrdersListViewBlocBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
      builder: (context, state) {
        if (state is ShowOrdersSuccess) {
          if (state.orders.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text("لا يوجد طلبات لعرضها")),
            );
          }
          return OrderItemsListView(orders: state.orders);
        } else if (state is ShowOrdersFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errorMessage),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: OrderItemsListView(orders: getDummyOrders()),
          );
        }
      },
    );
  }
}
