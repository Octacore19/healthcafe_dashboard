import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/plan/plan.dart';
import 'package:healthcafe_dashboard/data/remote/models/plan.dart';
import 'package:healthcafe_dashboard/data/repos/base.dart';
import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/domain/repos/wellness_plan.dart';
import 'package:healthcafe_dashboard/domain/requests/plan.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

const _ref = 'plans';

class IWellnessPlanRepo extends IBaseRepo implements WellnessPlanRepo {
  IWellnessPlanRepo({required FirebaseFirestore firestore})
      : _firestore = firestore {
    _subscription = _firestore
        .collection(_ref)
        .withConverter(
          fromFirestore: PlanResponse.fromFirestore,
          toFirestore: (PlanResponse res, _) => res.toJson(),
        )
        .where('is_active', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      final values = snapshot.docs.map((e) => e.data().toHive);
      List<HivePlan> existing = _box.values.toList();
      if (existing.isNotEmpty) {
        for (var hive in existing) {
          final found = values.firstWhereOrNull((e) => e.id == hive.id);
          found == null ? hive.delete() : _box.put(found.id, found);
        }
      } else {
        final users = {for (var v in values) v.id: v};
        _box.putAll(users);
      }
    });
  }

  final FirebaseFirestore _firestore;

  final _box = Hive.box<HivePlan>(wellnessPlanBox);

  StreamSubscription? _subscription;

  @override
  Stream<List<Plan>> get plans =>
      _box.watch().map((_) => _plans).startWith(_plans);

  @override
  Plan? fetchPlan(String? id) {
    final plan = _box.get(id);
    return plan == null ? null : Plan.fromHive(plan);
  }

  @override
  Future<void> addNewPlan(PlanRequest request) async {
    final f = DateFormat('yyyyMMddhhmmss');
    final id = 'WLP${f.format(DateTime.now())}';
    Map<String, dynamic> payload = request.toJson();
    final creationTime = FieldValue.serverTimestamp();
    payload['created_at'] = creationTime;
    payload['created_by'] = currentUser?.id;
    payload['is_active'] = true;
    await _firestore.collection(_ref).doc(id).set(payload);
  }

  @override
  Future<void> deletePlan(String? id) async {
    final data = {
      'is_active': false,
      'updated_at': FieldValue.serverTimestamp(),
      'updated_by': currentUser?.id,
    };
    await _firestore.collection(_ref).doc(id).update(data);
  }

  @override
  Future<void> updatePlan(String? id, PlanRequest request) async {
    Map<String, dynamic> payload = request.toJson();
    final updateTime = FieldValue.serverTimestamp();
    payload['updated_at'] = updateTime;
    payload['updated_by'] = currentUser?.id;
    await _firestore.collection(_ref).doc(id).update(payload);
  }

  @override
  Future<void> fetchAllPlans() async {
    final res = await _firestore
        .collection(_ref)
        .withConverter(
          fromFirestore: PlanResponse.fromFirestore,
          toFirestore: (PlanResponse res, _) => res.toJson(),
        )
        .where('is_active', isEqualTo: true)
        .get();
    List<HivePlan> existing = _box.values.toList();
    List<HivePlan> newData = res.docs.map((e) => e.data().toHive).toList();
    if (existing.isNotEmpty) {
      for (var hive in existing) {
        final found = newData.firstWhereOrNull((e) => e.id == hive.id);
        found == null ? hive.delete() : _box.put(found.id, found);
      }
    } else {
      final hiveUsers = {for (var value in newData) value.id: value};
      _box.putAll(hiveUsers);
    }
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
  }

  List<Plan> get _plans {
    return _box.values.map(Plan.fromHive).toList();
  }
}
