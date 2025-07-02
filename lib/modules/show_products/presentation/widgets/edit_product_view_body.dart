import 'package:flutter/material.dart';

import '../../../add_product/domain/entities/product_entity.dart';

class EditProductViewBody extends StatelessWidget {
  const EditProductViewBody({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Edit product ${product.name}"),
    );
  }
}
