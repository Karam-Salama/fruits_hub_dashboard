// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomUploadImageWidget extends StatefulWidget {
  const CustomUploadImageWidget({super.key, required this.onImageSelected});
  final ValueChanged<File?> onImageSelected;

  @override
  State<CustomUploadImageWidget> createState() =>
      _CustomUploadImageWidgetState();
}

class _CustomUploadImageWidgetState extends State<CustomUploadImageWidget> {
  bool isLoading = false;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await pickImageFromGallary();
          } on Exception catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
          isLoading = false;
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(child: Icon(Icons.add_a_photo, size: 30)),
            ),
            Visibility(
              visible: imageFile != null,
              child: IconButton(
                onPressed: () {
                  imageFile = null;
                  widget.onImageSelected(imageFile);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallary() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);
    widget.onImageSelected(imageFile!);
    setState(() {});
  }
}
