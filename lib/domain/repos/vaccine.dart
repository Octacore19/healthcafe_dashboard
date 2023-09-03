import 'package:healthcafe_dashboard/domain/models/plan.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/plan.dart';

abstract class VaccineRepo with BaseRepo {
  Stream<List<Plan>> get vaccines;

  Future<void> addNewVaccine(PlanRequest request);

  Future<void> fetchAllVaccines();

  Future<void> updateVaccine(String? id, PlanRequest request);

  Future<void> deleteVaccine(String? id);

  Plan? fetchVaccine(String? id);
}
