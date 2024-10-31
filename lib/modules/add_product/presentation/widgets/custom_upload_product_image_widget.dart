// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomUploadImageWidget extends StatelessWidget {
  CustomUploadImageWidget({
    super.key,
    required this.onPressed,
  });
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add_a_photo, size: 30)),
      ),
    );
  }
}
