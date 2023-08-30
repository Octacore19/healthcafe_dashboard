import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/model/appointment/appointment.dart';
import 'package:healthcafe_dashboard/domain/models/appointment_status.dart';
import 'package:healthcafe_dashboard/domain/models/appointment_type.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:intl/intl.dart';

class Appointment extends Equatable {
  final String id;
  final String name;
  final String address;
  final int price;
  final DateTime? date;
  final DateTime? createdAt;
  final AppointmentStatus status;
  final AppointmentType type;
  final String report;
  final AuthUser? user;

  const Appointment._({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    required this.type,
    required this.address,
    required this.report,
    this.user,
    this.date,
    this.createdAt,
  });

  factory Appointment.fromHive(HiveAppointment? app, AuthUser? user) {
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final creation = app?.createdAt;
    return Appointment._(
      id: app?.uid ?? 'Nil',
      name: app?.name ?? 'Nil',
      price: app?.price ?? 0,
      status: app?.status.appointmentStatus ?? AppointmentStatus.unknown,
      type: app?.type.appointmentType ?? AppointmentType.unknown,
      createdAt: creation == null ? null : formatter.parseUTC(creation),
      date: DateTime.tryParse(app?.appointmentDate ?? ''),
      address: app?.address ?? 'Nil',
      report: app?.report ?? 'Nil',
      user: user,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        date,
        createdAt,
        status,
        type,
        address,
        report,
        user,
      ];
}
