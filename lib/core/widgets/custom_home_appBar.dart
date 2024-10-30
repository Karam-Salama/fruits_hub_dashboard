// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class CustomHomeBar extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final Widget? trailing;

  const CustomHomeBar({
    super.key,
    this.leading,
    this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ??
          Image.asset(
            Assets.assetsIconsUserIcon,
            width: 40,
            height: 40,
          ),
      title: title != null
          ? Center(
              child: Text(
                title!,
                style: AppTextStyle.Cairo700style16.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            )
          : null,
      trailing: trailing ??
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const ShapeDecoration(
              shape: OvalBorder(),
            ),
            child: SvgPicture.asset(Assets.assetsIconsNotificationIcon),
          ),
    );
  }
}
