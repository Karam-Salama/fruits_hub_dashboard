import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomSectionHomeView extends StatelessWidget {
  const CustomSectionHomeView({
    super.key,
    required this.header,
    required this.text1,
    required this.onTap1,
    required this.image1,
    this.text2,
    this.onTap2,
    this.image2,
    this.isSecondItemVisible,
  });
  final String header;
  final String text1;
  final void Function() onTap1;
  final String image1;
  final String? text2;
  final void Function()? onTap2;
  final String? image2;
  final bool? isSecondItemVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: AppTextStyle.CairoBoldstyle22.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardHeight = constraints.maxWidth < 600 ? 120 : 160;
            return Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTap1,
                    child: Container(
                      height: cardHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.blackColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Text(
                              text1,
                              style: AppTextStyle.Cairo600style13.copyWith(
                                color: AppColors.blackColor,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Flexible(
                            child: SvgPicture.asset(
                              image1,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isSecondItemVisible ?? true)
                  const SizedBox(width: 16)
                else
                  SizedBox(),
                if (isSecondItemVisible ?? true)
                  Expanded(
                    child: InkWell(
                      onTap: onTap2,
                      child: Container(
                        height: cardHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.blackColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (image2 != null && image2!.isNotEmpty)
                              Flexible(
                                child: Text(
                                  text2 ?? '',
                                  style: AppTextStyle.Cairo600style13.copyWith(
                                    color: AppColors.blackColor,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            Flexible(
                              child: SvgPicture.asset(
                                image2!,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
