import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final Widget? trailing;
  final bool isVisibleLeading;
  final bool isVisibleTrailing;
  final bool isVisibleTitle;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
    this.isVisibleLeading = true,
    this.isVisibleTrailing = true,
    this.isVisibleTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Visibility(
        visible: isVisibleLeading,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteColor,
          ),
          child: leading ??
              Image.asset(
                Assets.assetsIconsUserIcon,
                width: 40,
                height: 40,
              ),
        ),
      ),
      title: title != null
          ? Visibility(
              visible: isVisibleTitle,
              child: Center(
                child: Text(
                  title!,
                  style: AppTextStyle.Cairo700style16.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          : null,
      trailing: Visibility(
        visible: isVisibleTrailing,
        child: trailing ??
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const ShapeDecoration(
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(Assets.assetsIconsNotificationIcon),
            ),
      ),
    );
  }
}
