// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../modules/dashboard/views/add_product_view.dart';
import '../../modules/dashboard/views/dashboard_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardView.routeName:
      return MaterialPageRoute(builder: (context) => const DashboardView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
