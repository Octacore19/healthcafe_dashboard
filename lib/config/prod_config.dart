import 'package:firebase_core/firebase_core.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase.dart';

class ProdConfig implements EnvConfig {
  @override
  String get baseUrl => const String.fromEnvironment('BASE_URL');

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'Healthcafe Admin';

  @override
  EnvType get type => EnvType.test;
}