import 'package:healthcafe_dashboard/domain/models/assessment.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/assessment.dart';

abstract class AssessmentRepo with BaseRepo {
  Stream<List<Assessment>> get assessments;

  Future<void> addNewAssessment(AssessmentRequest request);

  Future<void> fetchAssessmentList();

  Future<void> updateAssessment(String? id, AssessmentRequest request);

  Future<void> deleteAssessment(String? id);

  Assessment? fetchAssessment(String? id);
}