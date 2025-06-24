import 'package:flutter/material.dart';
import 'track_orders_view_body.dart';

class TrackOrdersView extends StatelessWidget {
  const TrackOrdersView({super.key});
  static const routeName = '/track-orders';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TrackOrdersViewBody(),
    );
  }
}
