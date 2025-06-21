import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ViewOrdersViewBody extends StatelessWidget {
  const ViewOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: 'View Orders'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 20),
        child: const CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No orders to display',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
