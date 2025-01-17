// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'custom_add_product_form.dart';

class AddProductViewBody extends StatelessWidget {
  const AddProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: const CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: CustomAddProductForm()),
          ],
        ),
      ),
    );
  }
}
