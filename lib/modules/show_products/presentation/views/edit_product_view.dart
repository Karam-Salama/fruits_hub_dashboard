import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repos/add_product_repos/product_repo.dart';
import '../../../../core/repos/images_repos/images_repo.dart';
import '../../../../core/services/service_locator.dart';
import '../../../add_product/domain/entities/product_entity.dart';
import '../../../add_product/presentation/manager/cubit/add_product_cubit.dart';
import '../widgets/edit_product_view_body.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddProductCubit(
          getIt.get<ImagesRepo>(),
          getIt.get<ProductRepo>(),
        ),
        child: EditProductViewBody(product: product),
      ),
    );
  }
}
