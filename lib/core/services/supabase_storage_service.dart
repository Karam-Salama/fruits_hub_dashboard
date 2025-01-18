// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as b;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_service.dart';

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;

  // إنشاء Bucket إذا لم يكن موجودًا
  static Future<void> createBucket(String bucketName) async {
    var buckets = await _supabase.client.storage.listBuckets();
    bool bucketExists = buckets.any((bucket) => bucket.id == bucketName);

    if (!bucketExists) {
      await _supabase.client.storage.createBucket(bucketName);
    }
  }

  // تهيئة Supabase
  static Future<void> initSupabase() async {
    _supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_PROJETC_URL'].toString(),
      anonKey: dotenv.env['SUPABASE_SECRET_KEY'].toString(),
    );
  }

  // رفع الصورة إلى Supabase
  @override
  Future<String> uploadImage(File file, String path) async {
    try {
      String fileName = b.basename(file.path); // اسم الملف مع الامتداد
      var result = await _supabase.client.storage
          .from('fruits_images')
          .upload('$path/$fileName', file);

      // جلب رابط URL صالح
      String publicUrl = _supabase.client.storage
          .from('fruits_images')
          .getPublicUrl('$path/$fileName')
          .toString();

      return publicUrl; // إعادة الرابط العام
    } catch (e) {
      throw Exception('Failed to upload image to Supabase: $e');
    }
  }
}
