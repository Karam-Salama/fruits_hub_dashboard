// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../modules/add_product/presentation/views/add_product_view.dart';
import '../../modules/dashboard/views/dashboard_view.dart';
import '../../modules/track_orders/track_orders_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardView.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());
    case TrackOrdersView.routeName:
      return MaterialPageRoute(builder: (context) => const TrackOrdersView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
