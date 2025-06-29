// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_service.dart';

import 'package:flutter/foundation.dart';

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

  // ✅ دعم File و Uint8List
  @override
  Future<String> uploadImage(Object file, String path) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final storage = _supabase.client.storage.from('fruits_images');

      if (kIsWeb && file is Uint8List) {
        final result = await storage.uploadBinary(
          '$path/$fileName.webp',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
        return storage.getPublicUrl('$path/$fileName.webp');
      } else if (file is File) {
        final result = await storage.upload(
          '$path/$fileName',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
        return storage.getPublicUrl('$path/$fileName');
      } else {
        throw Exception('Unsupported file type');
      }
    } catch (e) {
      throw Exception('Failed to upload image to Supabase: $e');
    }
  }
}
