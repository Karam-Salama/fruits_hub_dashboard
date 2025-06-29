// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_hub_dashboard/modules/add_user/domain/entities/user_entity.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../cubit/show_users_cubit.dart';
import '../cubit/show_users_states.dart';
import '../views/edit_user_view.dart';
import 'custom_user_operation_widget.dart';

class CustomUserSliverList extends StatelessWidget {
  const CustomUserSliverList({super.key, required this.users});
  final List<UserEntity> users;

  void _showDeleteConfirmationDialog(BuildContext context, String userId) {
    final cubit = BlocProvider.of<ShowUsersCubit>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: const Text("هل أنت متأكد أنك تريد حذف هذا المستخدم؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteUser(userId);
            },
            child: const Text(
              "حذف",
              style: TextStyle(color: AppColors.redColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (users.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text("لا يوجد مستخدمين لعرضهم")),
      );
    }

    return BlocListener<ShowUsersCubit, ShowUsersStates>(
      listener: (context, state) {
        if (state is DeleteUsersErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: SliverList(
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
                    backgroundImage:
                        const AssetImage(Assets.assetsIconsUserIcon),
                  ),
                  trailing: isMobile
                      ? _buildMobileActions(context, users[index])
                      : _buildDesktopActions(context, users[index]),
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
      ),
    );
  }

  Widget _buildDesktopActions(BuildContext context, UserEntity user) {
    return Wrap(
      spacing: 10,
      children: [
        CustomTwoOperationWidget(
          text: "تعديل",
          backGroundColor: AppColors.lighterBlueColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditUserView(user: user),
              ),
            );
          },
        ),
        CustomTwoOperationWidget(
          text: "حذف",
          backGroundColor: AppColors.lighterRedColor,
          onTap: () {
            _showDeleteConfirmationDialog(context, user.uId);
          },
        ),
      ],
    );
  }

  Widget _buildMobileActions(BuildContext context, UserEntity user) {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditUserView(user: user),
            ),
          );
        } else if (value == 'delete') {
          _showDeleteConfirmationDialog(context, user.uId);
        }
      },
    );
  }
}
