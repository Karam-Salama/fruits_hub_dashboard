import 'package:flutter/material.dart';

import '../widgets/add_product-view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const String routeName = 'add-product';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddProductViewBody());
  }
}
