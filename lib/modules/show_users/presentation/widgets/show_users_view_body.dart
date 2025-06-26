import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import 'custom_users_sliver_list_bloc_builder.dart';

class ShowUsersViewBody extends StatelessWidget {
  const ShowUsersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 30),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: size.height / 15)),
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: "صفحه عرض المستخدمين",
                isVisibleTrailing: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            CustomUsersSliverListBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
