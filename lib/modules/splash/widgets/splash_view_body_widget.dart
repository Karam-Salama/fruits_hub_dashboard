import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_hub_dashboard/modules/home/presentation/views/home_view.dart';

import '../../../core/functions/navigation.dart';
import '../../../core/utils/app_assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    delayedNavigate(HomeView.routeName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(Assets.assetsImagesSplashPlantImage),
        ),
        Center(child: SvgPicture.asset(Assets.assetsImagesSplashLogo)),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(Assets.assetsImagesSplashBottomImage),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void delayedNavigate(String routeName) {
    Future.delayed(const Duration(seconds: 2), () {
      customReplacementNavigate(context, routeName);
    });
  }
}
