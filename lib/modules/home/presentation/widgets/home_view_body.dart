import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/functions/navigation.dart';
import 'package:fruits_hub_dashboard/core/utils/app_assets.dart';
import 'package:fruits_hub_dashboard/modules/add_user/presentation/views/add_user_view.dart';
import 'package:fruits_hub_dashboard/modules/show_orders/presentation/views/show_orders_view.dart';
import 'package:fruits_hub_dashboard/modules/show_products/presentation/views/show_products_view.dart';
import 'package:fruits_hub_dashboard/modules/show_users/presentation/views/show_users_view.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../add_product/presentation/views/add_product_view.dart';
import 'custom_section_home_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: 'واجهة التحكم لتطبيق مستودع الفواكه والخضروات',
                isVisibleTrailing: false,
                isVisibleLeading: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: CustomSectionHomeView(
                text1: "إضافة منتج جديد",
                onTap1: () => customNavigate(context, AddProductView.routeName),
                image1: Assets.assetsImagesAddProduct,
                header: "إدارة المنتجات",
                text2: "عرض المنتجات",
                onTap2: () =>
                    customNavigate(context, ShowProductsView.routeName),
                image2: Assets.assetsImagesShowProduct,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: CustomSectionHomeView(
                text1: "إضافة مستخدم جديد",
                onTap1: () => customNavigate(context, AddUserView.routeName),
                image1: Assets.assetsImagesAddProduct,
                header: "إدارة المستخدمين",
                text2: "عرض المستخدمين",
                onTap2: () => customNavigate(context, ShowUsersView.routeName),
                image2: Assets.assetsImagesShowUsers,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: CustomSectionHomeView(
                header: "إدارة الطلبات",
                text1: "عرض الطلبات",
                onTap1: () => customNavigate(context, ShowOrdersView.routeName),
                image1: Assets.assetsImagesShowOrders,
                isSecondItemVisible: false,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }
}
