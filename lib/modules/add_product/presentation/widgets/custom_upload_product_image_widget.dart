// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/functions/pick_file.dart';

class CustomUploadImageWidget extends StatefulWidget {
  const CustomUploadImageWidget({super.key, required this.onImageSelected});
  final ValueChanged<dynamic> onImageSelected; // دعم File أو Uint8List

  @override
  State<CustomUploadImageWidget> createState() =>
      _CustomUploadImageWidgetState();
}

class _CustomUploadImageWidgetState extends State<CustomUploadImageWidget> {
  bool isLoading = false;
  File? imageFile;
  Uint8List? webImage;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            final result = await pickImage();
            if (result != null && result.files.isNotEmpty) {
              if (kIsWeb) {
                final bytes = result.files.first.bytes;
                if (bytes != null) {
                  setState(() {
                    webImage = bytes;
                    widget.onImageSelected(bytes);
                  });
                }
              } else {
                final filePath = result.files.first.path;
                if (filePath != null) {
                  final file = File(filePath);
                  setState(() {
                    imageFile = file;
                    widget.onImageSelected(file);
                  });
                }
              }
            }
          } catch (e) {
            if (kDebugMode) print(e);
          } finally {
            isLoading = false;
            setState(() {});
          }
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
              child: _buildImagePreview(),
            ),
            if (imageFile != null || webImage != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      imageFile = null;
                      webImage = null;
                      widget.onImageSelected(null);
                    });
                  },
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (imageFile == null && webImage == null) {
      return const Center(child: Icon(Icons.add_a_photo, size: 30));
    }

    if (kIsWeb) {
      return webImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(webImage!, fit: BoxFit.cover),
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      return imageFile != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(imageFile!, fit: BoxFit.cover),
            )
          : const Center(child: CircularProgressIndicator());
    }
  }
}
