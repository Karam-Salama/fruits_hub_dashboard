import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/fruits_hub_dashboard.dart';
import 'core/services/service_bloc_observer.dart';
import 'core/services/service_locator.dart';
import 'core/services/supabase_storage_service.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await SupabaseStorageService.initSupabase();
  await SupabaseStorageService.createBucket('fruits_images');
  setUpServiceLocator();
  runApp(const FruitsHubDashboard());
}
