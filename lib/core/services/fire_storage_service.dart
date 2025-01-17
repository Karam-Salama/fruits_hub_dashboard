import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'storage_service.dart';

class FireStorageService implements StorageService {
  
  final storageReference = FirebaseStorage.instance.ref();
  
  @override
  Future<String> uploadImage(File file, String path) async {
    String fileName = basename(file.path);
    String extenstionName = extension(file.path);
    var fileReference = storageReference.child("$path/$fileName.$extenstionName");
    await fileReference.putFile(file);
    var fileUrl = fileReference.getDownloadURL();
    return fileUrl;
  }
}
