import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: appointmentId, adapterName: 'AppointmentAdapter')
class HiveAppointment extends HiveObject {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int? price;

  @HiveField(3)
  String? appointmentDate;

  @HiveField(4)
  String? createdAt;

  @HiveField(5)
  int? status;

  @HiveField(6)
  String? testId;
}