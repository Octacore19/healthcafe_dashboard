import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase/stage_options.dart';

class StageConfig implements EnvConfig {
  StageConfig() {
    _init();
  }

  @override
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  void _init() async {
    await dotenv.load(fileName: '.env.stage');
  }

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'Healthcafe Admin-stage';

  @override
  EnvType get type => EnvType.test;
}