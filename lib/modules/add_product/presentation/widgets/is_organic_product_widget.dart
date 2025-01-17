import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class IsOrganicCheckboxWidget extends StatelessWidget {
  const IsOrganicCheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, -10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            side: const BorderSide(color: AppColors.greyColor, width: 1.0),
            onChanged: onChanged,
          ),
          Text(
            "Is organic product?",
            style: AppTextStyle.Cairo600style16.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
