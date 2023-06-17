import 'package:firebase_core/firebase_core.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase/stage_options.dart';

class StageConfig implements EnvConfig {
  @override
  String get baseUrl => 'http://localhost:5001/healthcafe-dev/us-central1';

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'healthcafe_admin_stage';

  @override
  EnvType get type => EnvType.test;
}