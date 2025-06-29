import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/repos/show_products_repo.dart';
import '../cubit/show_products_cubit.dart';
import '../widgets/show_products_view_body.dart';

class ShowProductsView extends StatelessWidget {
  const ShowProductsView({super.key});
  static const String routeName = 'show-products-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ShowProductsCubit(getIt.get<ShowProductsRepo>())..getProducts(),
        child: ShowProductsViewBody(),
      ),
    );
  }
}
