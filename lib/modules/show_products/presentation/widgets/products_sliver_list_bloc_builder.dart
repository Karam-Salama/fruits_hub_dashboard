import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/functions/get_dummy_product.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../cubit/show_products_cubit.dart';
import '../cubit/show_products_states.dart';
import 'custom_products_sliver_list.dart';

class ProductsSliverListBlocBuilder extends StatelessWidget {
  const ProductsSliverListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowProductsCubit, ShowProductsState>(
      builder: (context, state) {
        if (state is ShowProductsSuccess) {
          return CustomProductsSliverList(products: state.products);
        } else if (state is ShowProductsFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errorMessage),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: CustomProductsSliverList(products: getDummyProducts()),
          );
        }
      },
    );
  }
}
