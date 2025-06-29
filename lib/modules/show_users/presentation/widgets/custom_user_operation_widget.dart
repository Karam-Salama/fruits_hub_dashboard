// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';

class CustomTwoOperationWidget extends StatelessWidget {
  const CustomTwoOperationWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.backGroundColor,
  });
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
        child: Center(child: Text(text, style: AppTextStyle.Cairo400style13)),
      ),
    );
  }
}
