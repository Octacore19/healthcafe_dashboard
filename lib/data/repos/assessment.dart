import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/assessment/assessment.dart';
import 'package:healthcafe_dashboard/data/remote/models/assessment.dart';
import 'package:healthcafe_dashboard/data/repos/base.dart';
import 'package:healthcafe_dashboard/domain/models/assessment.dart';
import 'package:healthcafe_dashboard/domain/repos/assessment.dart';
import 'package:healthcafe_dashboard/domain/requests/assessment.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

const _ref = 'assessments';

class IAssessmentRepo extends IBaseRepo implements AssessmentRepo {
  IAssessmentRepo({required FirebaseFirestore firestore}) : _db = firestore {
    _listenForUpdates();
  }

  final FirebaseFirestore _db;
  final _box = Hive.box<HiveAssessment>(assessmentBox);

  StreamSubscription? _subscription;

  CollectionReference<AssessmentResponse> get collection =>
      _db.collection(_ref).withConverter(
            fromFirestore: AssessmentResponse.fromFirestore,
            toFirestore: (AssessmentResponse res, _) => res.toJson(),
          );

  @override
  Stream<List<Assessment>> get assessments =>
      _box.watch().map((e) => _assessments).startWith(_assessments);

  @override
  Future<void> fetchAssessmentList() async {
    final res = await collection.where('is_active', isEqualTo: true).get();
    List<HiveAssessment> newData =
        res.docs.map((e) => e.data().toHive).toList();
    await _box.clear();
    final users = {for (var value in newData) value.id: value};
    await _box.putAll(users);
  }

  @override
  Future<void> addNewAssessment(AssessmentRequest request) async {
    final f = DateFormat('yyyyMMddhhmmss');
    final id = 'ASS${f.format(DateTime.now())}';
    Map<String, dynamic> payload = request.toJson();
    final creationTime = FieldValue.serverTimestamp();
    payload['created_at'] = creationTime;
    payload['created_by'] = currentUser?.id;
    payload['is_active'] = true;
    await _db.collection(_ref).doc(id).set(payload);
  }

  @override
  Future<void> deleteAssessment(String? id) async {
    final data = {
      'is_active': false,
      'updated_at': FieldValue.serverTimestamp(),
      'updated_by': currentUser?.id,
    };
    await _db.collection(_ref).doc(id).update(data);
  }

  @override
  Assessment? fetchAssessment(String? id) {
    final assessment = id == null ? null : _box.get(id);
    return assessment == null ? null : Assessment.fromHive(assessment);
  }

  @override
  Future<void> updateAssessment(String? id, AssessmentRequest request) async {
    Map<String, dynamic> payload = request.toJson();
    final updateTime = FieldValue.serverTimestamp();
    payload['updated_at'] = updateTime;
    payload['updated_by'] = currentUser?.id;
    await _db.collection(_ref).doc(id).update(payload);
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
      final users = {for (var value in values) value.id: value};
      await _box.putAll(users);
    });
  }

  List<Assessment> get _assessments {
    return _box.values.map(Assessment.fromHive).toList();
  }
}
