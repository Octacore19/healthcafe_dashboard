import 'package:firebase_core/firebase_core.dart';

abstract class EnvConfig {
  abstract final String name;
  abstract final String baseUrl;
  abstract final FirebaseOptions firebase;
  abstract final EnvType type;
}

enum EnvType {
  dev,
  test,
  prod,
}

extension EnvExt on EnvConfig {
  bool get isProd => type == EnvType.prod;

  bool get isStaging => type == EnvType.test;

  bool get isDev => !(isStaging || isProd);
}