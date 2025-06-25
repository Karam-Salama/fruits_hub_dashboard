// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/modules/show_products/presentation/views/show_products_view.dart';

import '../../modules/add_product/presentation/views/add_product_view.dart';
import '../../modules/add_user/presentation/views/add_user_view.dart';
import '../../modules/home/presentation/views/home_view.dart';
import '../../modules/show_users/presentation/views/show_users_view.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/show_orders/presentation/views/show_orders_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (context) => const AddProductView());
    case ShowOrdersView.routeName:
      return MaterialPageRoute(builder: (context) => const ShowOrdersView());
    case AddUserView.routeName:
      return MaterialPageRoute(builder: (context) => const AddUserView());
    case ShowProductsView.routeName:
      return MaterialPageRoute(builder: (context) => const ShowProductsView());
    case ShowUsersView.routeName:
      return MaterialPageRoute(builder: (context) => const ShowUsersView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
