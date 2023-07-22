import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/firebase/prod_options.dart';

class ProdConfig implements EnvConfig {
  ProdConfig() {
    _init();
  }

  @override
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  void _init() async {
    await dotenv.load(fileName: '.env');
  }

  @override
  FirebaseOptions get firebase => DefaultFirebaseOptions.currentPlatform;

  @override
  String get name => 'Healthcafe Admin';

  @override
  EnvType get type => EnvType.test;
}