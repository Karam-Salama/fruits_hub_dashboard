import 'package:flutter/material.dart';
import '../widgets/show_orders_view_body.dart';

class ShowOrdersView extends StatelessWidget {
  const ShowOrdersView({super.key});
  static const routeName = '/show-orders';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShowOrdersViewBody(),
    );
  }
}
