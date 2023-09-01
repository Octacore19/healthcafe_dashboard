import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';

abstract class AppointmentRepo with BaseRepo {
  Stream<List<Appointment>> get appointments;

  Future<void> fetchAppointmentsList();
}