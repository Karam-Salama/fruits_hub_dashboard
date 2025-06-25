import 'package:flutter/material.dart';

import '../widgets/show_products_view_body.dart';

class ShowProductsView extends StatelessWidget {
  const ShowProductsView({super.key});
  static const String routeName = 'show-products-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShowProductsViewBody(),
    );
  }
}
