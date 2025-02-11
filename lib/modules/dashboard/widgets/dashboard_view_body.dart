import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/functions/navigation.dart';
import 'package:fruits_hub_dashboard/core/utils/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_btn.dart';
import '../../add_product/presentation/views/add_product_view.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: size.height / 3)),
            SliverToBoxAdapter(
              child: CustomButton(
                text: 'Add Product',
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {
                  customNavigate(context, AddProductView.routeName);
                },
                style: AppTextStyle.CairoBoldstyle20,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 30)),
            SliverToBoxAdapter(
              child: CustomButton(
                text: 'All Orders',
                mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () {},
                style: AppTextStyle.CairoBoldstyle20,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 3)),
          ],
        ),
      ),
    );
  }
}

