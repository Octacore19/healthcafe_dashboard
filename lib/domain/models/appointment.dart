import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/appointment.dart';
import 'package:intl/intl.dart';

class Appointment extends Equatable {
  final String id;
  final String name;
  final int price;
  final DateTime? appointmentDate;
  final DateTime? createdAt;
  final String status;

  const Appointment._({
    required this.id,
    required this.name,
    required this.price,
    this.appointmentDate,
    this.createdAt,
    required this.status,
  });

  factory Appointment.fromHive(HiveAppointment? app) {
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final creation = app?.createdAt;
    return Appointment._(
      id: app?.uid ?? 'Nil',
      name: app?.name ?? 'Nil',
      price: app?.price ?? 0,
      status: app?.status.toString() ?? 'Nil',
      createdAt: creation == null ? null : formatter.parseUTC(creation),
      appointmentDate: DateTime.tryParse(app?.appointmentDate ?? ''),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        appointmentDate,
        createdAt,
        status,
      ];
}
