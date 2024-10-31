// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_home_appBar.dart';
import 'custom_add_product_form.dart';

class AddProductViewBody extends StatelessWidget {
  const AddProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: size.height / 20)),
            SliverToBoxAdapter(
              child: CustomHomeBar(
                title: 'Add Product',
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 20)),
            const SliverToBoxAdapter(child: CustomAddProductForm())
          ],
        ),
      ),
    );
  }
}
