import 'package:firebase_core/firebase_core.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase/stage_options.dart';

class StageConfig implements EnvConfig {
  @override
  String get baseUrl => const String.fromEnvironment('BASE_URL');

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'Healthcafe Admin-stage';

  @override
  EnvType get type => EnvType.test;
}
