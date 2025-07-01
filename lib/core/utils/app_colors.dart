import 'package:flutter/material.dart';

abstract class AppColors {
  // background and primary
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF1B5E37);
  static const Color transparent = Colors.transparent;

  // secondary
  static const Color secondaryColor = Color(0xFF2D9F5D);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF949D9E);
  static const Color darkGreyColor = Color(0xFF4E5556);
  static const Color lightGreyColor = Color(0xFFC9CECF);
  static const Color dotsIndicatorColor = Color(0xFFD8D8D8);
  static const Color redColor = Color(0xFFEF4444);
  static const Color blueColor = Color(0xFF3A7FF1);
  static const Color greenColor = Color(0xFF43A047);
  static const Color yellowColor = Color(0xFFFDD835);
  static const Color orangeColor = Color(0xFFF4A91F);

  static const Color lighterBlueColor = Color(0xFFE7EDF6);
  static const Color lighterRedColor = Color(0xFFFEF2F2);

  static const Color pendingColor = Color(0xFFFFA500); // Orange (Pending)
  static const Color acceptedColor = Color(0xFF4CAF50); // Green (Accepted)
  static const Color deliveredColor = Color(0xFF2196F3); // Blue (Delivered)
  static const Color cancelledColor = Color(0xFFF44336); // Red (Cancelled)
}
