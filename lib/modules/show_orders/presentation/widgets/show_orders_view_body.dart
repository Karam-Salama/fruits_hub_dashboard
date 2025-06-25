import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

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
            SliverToBoxAdapter(child: SizedBox(height: size.height / 20)),
          ],
        ),
      ),
    );
  }
}
