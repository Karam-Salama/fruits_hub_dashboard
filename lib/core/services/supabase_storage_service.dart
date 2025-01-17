// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_service.dart';

class SupabaseStorageService implements StorageService {
  static late Supabase _supabase;
  static createBucket(String bucketName) async {
    var buckets = await _supabase.client.storage.listBuckets();
    bool bucketExists = false;
    for (var bucket in buckets) {
      if (bucket.id == bucketName) {
        bucketExists = true;
        break;
      }
    }
    if (!bucketExists) {
      await _supabase.client.storage.createBucket(bucketName);
    }
  }

  static initSupabase() async {
    _supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_PROJETC_URL'].toString(),
      anonKey: dotenv.env['SUPABASE_SECRET_KEY'].toString(),
    );
  }

  @override
  Future<String> uploadImage(File file, String path) async {
    String fileName = basename(file.path);
    String extenstionName = extension(file.path);
    var result = await _supabase.client.storage
        .from('fruits_images')
        .upload("$path/$fileName", file);

    final String publicUrl = _supabase.client.storage
        .from('fruits_images')
        .getPublicUrl("$path/$fileName");

    return result;
  }
}
