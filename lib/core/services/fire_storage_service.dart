import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as b;

import 'storage_service.dart';

import 'package:flutter/foundation.dart';

class FireStorageService implements StorageService {
  final storageReference = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadImage(Object file, String path) async {
    try {
      late Reference fileReference;

      if (kIsWeb && file is Uint8List) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fileReference = storageReference.child('$path/$fileName.webp');
        await fileReference.putData(file);
      } else if (file is File) {
        String fileName = b.basename(file.path);
        fileReference = storageReference.child('$path/$fileName');
        await fileReference.putFile(file);
      } else {
        throw Exception('Unsupported file type');
      }

      return await fileReference.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image to Firebase: $e');
    }
  }
}
