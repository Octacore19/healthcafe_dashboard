import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/plan/plan.dart';
import 'package:healthcafe_dashboard/data/remote/models/plan.dart';
import 'package:healthcafe_dashboard/data/repos/base.dart';
import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/domain/repos/vaccine.dart';
import 'package:healthcafe_dashboard/domain/requests/plan.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

const _ref = 'vaccines';

class IVaccineRepo extends IBaseRepo implements VaccineRepo {
  IVaccineRepo({required FirebaseFirestore firestore})
      : _firestore = firestore {
    _listenForUpdates();
  }

  final FirebaseFirestore _firestore;

  final _box = Hive.box<HivePlan>(vaccineBox);

  StreamSubscription? _subscription;

  CollectionReference<PlanResponse> get collection =>
      _firestore.collection(_ref).withConverter(
            fromFirestore: PlanResponse.fromFirestore,
            toFirestore: (PlanResponse res, _) => res.toJson(),
          );

  @override
  Stream<List<Plan>> get vaccines =>
      _box.watch().map((_) => _vaccines).startWith(_vaccines);

  @override
  Plan? fetchVaccine(String? id) {
    final plan = id == null ? null : _box.get(id);
    return plan == null ? null : Plan.fromHive(plan);
  }

  @override
  Future<void> addNewVaccine(PlanRequest request) async {
    final f = DateFormat('yyyyMMddhhmmss');
    final id = 'VAC${f.format(DateTime.now())}';
    Map<String, dynamic> payload = request.toJson();
    final creationTime = FieldValue.serverTimestamp();
    payload['created_at'] = creationTime;
    payload['created_by'] = currentUser?.id;
    payload['is_active'] = true;
    await _firestore.collection(_ref).doc(id).set(payload);
  }

  @override
  Future<void> deleteVaccine(String? id) async {
    final data = {
      'is_active': false,
      'updated_at': FieldValue.serverTimestamp(),
      'updated_by': currentUser?.id,
    };
    await _firestore.collection(_ref).doc(id).update(data);
  }

  @override
  Future<void> updateVaccine(String? id, PlanRequest request) async {
    Map<String, dynamic> payload = request.toJson();
    final updateTime = FieldValue.serverTimestamp();
    payload['updated_at'] = updateTime;
    payload['updated_by'] = currentUser?.id;
    await _firestore.collection(_ref).doc(id).update(payload);
  }

  @override
  Future<void> fetchAllVaccines() async {
    final res = await collection.where('is_active', isEqualTo: true).get();
    List<HivePlan> newData = res.docs.map((e) => e.data().toHive).toList();
    await _box.clear();
    final hiveUsers = {for (var value in newData) value.id: value};
    await _box.putAll(hiveUsers);
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
  }

  void _listenForUpdates() {
    _subscription = collection
        .where('is_active', isEqualTo: true)
        .snapshots()
        .listen((snapshot) async {
      final values = snapshot.docs.map((e) => e.data().toHive);
      await _box.clear();
      final users = {for (var v in values) v.id: v};
      await _box.putAll(users);
    });
  }

  List<Plan> get _vaccines {
    return _box.values.map(Plan.fromHive).toList();
  }
}
