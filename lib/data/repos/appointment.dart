import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:healthcafe_dashboard/data/local/model/appointment/appointment.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/appointment.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class IAppointmentRepo implements AppointmentRepo {
  IAppointmentRepo({required FirebaseFirestore firebaseFirestore})
      : _db = firebaseFirestore {
    final res = _appCollection
        .snapshots()
        .map((e) => e.docs.map((e) => e.data().toHive).toList());

    _appSub = res.listen((event) {
      final apps = {for (var v in event) v.uid: v};
      _box.putAll(apps);
    });
    _appSub?.cancel();
  }

  final FirebaseFirestore _db;

  StreamSubscription? _appSub;

  final _box = Hive.box<HiveAppointment>(appointmentBox);

  final _userBox = Hive.box<HiveUser>(userBox);

  Query<AppointmentResponse> get _appCollection {
    return _db.collection('appointments').withConverter(
          fromFirestore: AppointmentResponse.fromFirestore,
          toFirestore: (AppointmentResponse res, _) => res.toJson(),
        );
  }

  @override
  Future<void> fetchAppointmentsList() async {
    _box.clear();
    _appCollection.get().then((value) {
      for (var doc in value.docs) {
        final data = doc.data();
        _box.put(data.uid, data.toHive);
      }
    });
    _appSub?.resume();
  }

  @override
  Stream<List<Appointment>> get appointments =>
      _box.watch().map((_) => _appointments).startWith(_appointments);

  List<Appointment> get _appointments {
    final hUsers = _userBox.values;
    return _box.values.map((e) {
      final user = hUsers
          .map(AuthUser.fromHive)
          .firstWhereOrNull((user) => user.id == e.user);
      return Appointment.fromHive(e, user);
    }).toList();
  }

  @override
  Future<void> close() async {
    _appSub?.cancel();
  }
}
