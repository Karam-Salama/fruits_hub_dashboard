import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/domain/entities/order_entity.dart';

import 'order_item_widget.dart';

class OrderItemsListView extends StatelessWidget {
  const OrderItemsListView({super.key, required this.orders});
  final List<OrderEntity> orders;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: orders.length,
        (context, index) {
          return OrderItemWidget(orderEntity: orders[index]);
        },
      ),
    );
  }
}
