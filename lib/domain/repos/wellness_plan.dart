import 'package:healthcafe_dashboard/domain/models/wellness_plan.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/wellness_plan.dart';

abstract class WellnessPlanRepo with BaseRepo {
  Stream<List<WellnessPlan>> get plans;

  Future<void> addNewPlan(WellnessPlanRequest request);

  Future<void> fetchAllPlans();

  Future<void> updatePlan(String? id, WellnessPlanRequest request);

  Future<void> deletePlan(String? id);

  WellnessPlan? fetchPlan(String? id);
}