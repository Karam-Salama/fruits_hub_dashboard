import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import 'custom_edit_user_form.dart';

class EditUserViewBody extends StatelessWidget {
  const EditUserViewBody({super.key, required this.user});
  final UserEntity user;
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
                title: "صفحة تعديل المستخدم",
                isVisibleTrailing: false,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height / 20)),
            SliverToBoxAdapter(child: CustomEditUserForm(user: user)),
          ],
        ),
      ),
    );
  }
}
