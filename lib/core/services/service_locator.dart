import 'package:fruits_hub_dashboard/core/repos/add_product_repos/product_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/add_product_repos/product_repo_implementation.dart';
import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

import '../../modules/add_user/data/repo/add_user_repo_imple.dart';
import '../../modules/add_user/domain/repo/add_user_repo.dart';
import '../../modules/show_products/data/repos/show_products_repo_implem.dart';
import '../../modules/show_products/domain/repos/show_products_repo.dart';
import '../../modules/show_users/data/repo/show_users_repo_imple.dart';
import '../../modules/show_users/domain/repo/show_user_repo.dart';
import '../repos/images_repos/images_repo.dart';
import '../repos/images_repos/images_repo_implementation.dart';
import 'database_service.dart';
import 'service_firebase_auth.dart';
import 'service_firebase_firestore.dart';
import 'supabase_storage_service.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<DatabaseService>(FirabaseFirestoreService());
  getIt.registerSingleton<ImagesRepo>(
      ImagesRepoImplementation(getIt.get<StorageService>()));
  getIt.registerSingleton<ProductRepo>(
      ProductRepoImplementation(getIt.get<DatabaseService>()));

  //! Authentication
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AddUserRepo>(
    AddUserRepoImplement(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

  //! Show Users
  getIt.registerSingleton<ShowUsersRepo>(
    ShowUsersRepoImplement(databaseService: getIt<DatabaseService>()),
  );

  //! Show Products
  getIt.registerSingleton<ShowProductsRepo>(
      ShowProductsRepoImplem(databaseService: getIt<DatabaseService>()));
}
