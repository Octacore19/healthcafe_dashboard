import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:healthcafe_dashboard/config/dev_config.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/config/prod_config.dart';
import 'package:healthcafe_dashboard/config/stage_config.dart';
import 'package:healthcafe_dashboard/data/local/model/appointment/appointment.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/assessment/assessment.dart';
import 'package:healthcafe_dashboard/data/local/model/plan/plan.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static bool _initialized = false;

  static late final EnvConfig _env;

  static late final FirebaseAuth _auth;

  static late final FirebaseFirestore _firestore;

  static late final SharedPreferences _pref;

  static late final FirebaseStorage _storage;

  static EnvConfig get env => _env;

  static FirebaseAuth get auth => _auth;

  static SharedPreferences get pref => _pref;

  static FirebaseFirestore get db => _firestore;

  static FirebaseStorage get storage => _storage;

  static Future<void> init() async {
    if (_initialized) return;

    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/poppins_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['assets/poppins_fonts'], license);
    });
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('assets/inter/OFL.txt');
      yield LicenseEntryWithLineBreaks(['assets/inter'], license);
    });

    const appEnv = String.fromEnvironment('APP_ENV');
    _env = appEnv == "dev"
        ? DevConfig()
        : appEnv == "stage"
            ? StageConfig()
            : ProdConfig();

    _pref = await SharedPreferences.getInstance();

    await Firebase.initializeApp(
      name: kIsWeb ? null : _env.name,
      options: _env.firebase,
    );

    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _firestore.settings = const Settings(persistenceEnabled: true);

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorage.webStorageDirectory,
    );

    if (_env is DevConfig) {
      await _auth.useAuthEmulator("localhost", 9099);
      _firestore.useFirestoreEmulator("localhost", 8080);
      await _storage.useStorageEmulator("localhost", 9199);
    }

    // Hive
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AppointmentAdapter());
    Hive.registerAdapter(PlanAdapter());
    Hive.registerAdapter(AssessmentAdapter());

    await Hive.openBox<HiveUser>(adminBox);
    await Hive.openBox<HiveUser>(userBox);
    await Hive.openBox<HiveAppointment>(appointmentBox);
    await Hive.openBox<HivePlan>(wellnessPlanBox);
    await Hive.openBox<HivePlan>(vaccineBox);
    await Hive.openBox<HiveAssessment>(assessmentBox);

    _initialized = true;
  }
}
