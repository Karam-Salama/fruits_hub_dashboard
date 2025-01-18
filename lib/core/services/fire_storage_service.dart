import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as b;

import 'storage_service.dart';

class FireStorageService implements StorageService {
  final storageReference = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadImage(File file, String path) async {
    try {
      String fileName = b.basename(file.path); // اسم الملف مع الامتداد
      var fileReference = storageReference.child('$path/$fileName');

      // رفع الملف
      await fileReference.putFile(file);

      // جلب رابط التنزيل
      String fileUrl = await fileReference.getDownloadURL();
      return fileUrl;
    } catch (e) {
      throw Exception('Failed to upload image to Firebase: $e');
    }
  }
}
