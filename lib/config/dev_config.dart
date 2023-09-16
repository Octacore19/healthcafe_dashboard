import 'package:firebase_core/firebase_core.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase/dev_options.dart';

class DevConfig implements EnvConfig {
  @override
  String get baseUrl => const String.fromEnvironment('BASE_URL');

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'Healthcafe Admin-dev';

  @override
  EnvType get type => EnvType.dev;
}
