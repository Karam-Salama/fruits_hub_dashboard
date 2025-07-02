import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/presentation/widgets/update_order_builder.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/repos/show_orders_repo.dart';
import '../cubit/show_order_cubit.dart';
import '../cubit/update_order_cubit.dart';
import '../widgets/show_orders_view_body.dart';

class ShowOrdersView extends StatelessWidget {
  const ShowOrdersView({super.key});
  static const routeName = '/show-orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ShowOrdersCubit(showOrdersRepo: getIt<ShowOrdersRepo>())
                  ..getOrders(),
          ),
          BlocProvider(
            create: (context) =>
                UpdateOrderCubit(showOrdersRepo: getIt<ShowOrdersRepo>()),
          ),
        ],
        child: UpdateOrderBuilder(child: ShowOrdersViewBody()),
      ),
    );
  }
}
