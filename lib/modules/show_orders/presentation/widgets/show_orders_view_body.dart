import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/functions/get_dummy_orders.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../cubit/show_order_cubit.dart';
import '../cubit/show_order_states.dart';
import 'order_items_list_view.dart';

class ShowOrdersViewBody extends StatelessWidget {
  const ShowOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: size.height / 15)),
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: "صفحه عرض الطلبات",
                isVisibleTrailing: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 50)),
            OrdersListViewBlocBuilder(),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 15)),
          ],
        ),
      ),
    );
  }
}

class OrdersListViewBlocBuilder extends StatelessWidget {
  const OrdersListViewBlocBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
      builder: (context, state) {
        if (state is ShowOrdersSuccess) {
          return OrderItemsListView(orders: state.orders);
        } else if (state is ShowOrdersFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errorMessage),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: OrderItemsListView(orders: getDummyOrders()),
          );
        }
      },
    );
  }
}
