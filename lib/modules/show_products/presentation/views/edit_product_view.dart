import 'package:flutter/material.dart';

import '../../../add_product/domain/entities/product_entity.dart';
import '../widgets/edit_product_view_body.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: EditProductViewBody(product: product));
  }
}
