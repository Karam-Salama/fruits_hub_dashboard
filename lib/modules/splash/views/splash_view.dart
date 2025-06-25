import 'package:flutter/material.dart';

import '../widgets/splash_view_body_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const routeName = '/splash-view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}