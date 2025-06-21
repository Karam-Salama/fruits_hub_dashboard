import 'package:flutter/material.dart';

import '../widgets/view_orders_view_body.dart';

class ViewOrdersView extends StatelessWidget {
  const ViewOrdersView({super.key});
  static const String routeName = 'view-orders-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ViewOrdersViewBody());
  }
}
