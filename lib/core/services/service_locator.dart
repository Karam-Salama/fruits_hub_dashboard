

import 'package:fruits_hub_dashboard/core/repos/add_product_repos/product_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/add_product_repos/product_repo_implementation.dart';
import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

import '../repos/images_repos/images_repo.dart';
import '../repos/images_repos/images_repo_implementation.dart';
import 'database_service.dart';
import 'service_firebase_firestore.dart';
import 'supabase_storage_service.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<DatabaseService>(FirabaseFirestoreService());
  getIt.registerSingleton<ImagesRepo>(ImagesRepoImplementation(getIt.get<StorageService>()));
  getIt.registerSingleton<ProductRepo>(ProductRepoImplementation(getIt.get<DatabaseService>()));
}
