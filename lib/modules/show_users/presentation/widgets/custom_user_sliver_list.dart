// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'custom_user_operation_widget.dart';

class CustomUserSliverList extends StatelessWidget {
  const CustomUserSliverList({super.key, required this.users});
  final List<UserEntity> users;
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    if (users.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text("لا يوجد مستخدمين لعرضهم")),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0.0 : 16.0,
            vertical: 4.0,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  users[index].name,
                  style: AppTextStyle.Cairo400style13.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                subtitle: Text(
                  users[index].email,
                  style: AppTextStyle.Cairo400style13.copyWith(fontSize: 12),
                ),
                leading: CircleAvatar(
                  radius: isMobile ? 20 : 30,
                  backgroundImage: AssetImage(Assets.assetsIconsUserIcon),
                ),
                trailing: isMobile
                    ? _buildMobileActions(context)
                    : _buildDesktopActions(context),
              ),
              const Divider(
                height: 1,
                endIndent: 20,
                indent: 20,
              ),
            ],
          ),
        ),
        childCount: users.length,
      ),
    );
  }

  Widget _buildDesktopActions(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        CustomUserOperationWidget(
          text: "تعديل",
          icon: Assets.assetsIconsEditUser,
          color: AppColors.blueColor,
          backGroundColor: AppColors.lighterBlueColor,
          onTap: () {},
        ),
        CustomUserOperationWidget(
          text: "حذف",
          icon: Assets.assetsIconsDeleteUser,
          color: AppColors.redColor,
          backGroundColor: AppColors.lighterRedColor,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMobileActions(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.assetsIconsEditUser,
                color: AppColors.blueColor,
                width: 20,
              ),
              const SizedBox(width: 8),
              const Text("تعديل"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.assetsIconsDeleteUser,
                color: AppColors.redColor,
                width: 20,
              ),
              const SizedBox(width: 8),
              const Text("حذف"),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          // Handle edit
        } else if (value == 'delete') {
          // Handle delete
        }
      },
    );
  }
}
