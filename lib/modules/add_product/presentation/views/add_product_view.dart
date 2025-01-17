import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/services/service_locator.dart';
import 'package:fruits_hub_dashboard/modules/add_product/presentation/manager/cubit/add_product_cubit.dart';

import '../../../../core/repos/add_product_repos/product_repo.dart';
import '../../../../core/repos/images_repos/images_repo.dart';
import '../widgets/add_product-view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  static const String routeName = 'add-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddProductCubit(
          getIt.get<ImagesRepo>(),
          getIt.get<ProductRepo>(),
        ),
        child: const AddProductViewBody(),
      ),
    );
  }
}
