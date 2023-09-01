import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/plan.dart';

abstract class WellnessPlanRepo with BaseRepo {
  Stream<List<Plan>> get plans;

  Future<void> addNewPlan(PlanRequest request);

  Future<void> fetchAllPlans();

  Future<void> updatePlan(String? id, PlanRequest request);

  Future<void> deletePlan(String? id);

  Plan? fetchPlan(String? id);
}