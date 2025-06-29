// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_text_styles.dart';

class CustomTwoOperationWidget extends StatelessWidget {
  const CustomTwoOperationWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.text,
    required this.backGroundColor,
  });
  final String icon;
  final Color color;
  final Color backGroundColor;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height / 20,
        width: size.width / 15,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: AppTextStyle.Cairo400style13),
            const SizedBox(width: 5),
            SvgPicture.asset(icon, color: color, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
