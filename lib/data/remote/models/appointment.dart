import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/model/appointment/appointment.dart';

class AppointmentResponse {
  final String? uid;
  final String? name;
  final String? testId;
  final int? status;
  final int? price;
  final Timestamp? createdAt;
  final String? appointmentDate;
  final String? user;
  final String? address;
  final String? report;
  final int? type;

  AppointmentResponse._({
    this.uid,
    this.name,
    this.testId,
    this.status,
    this.price,
    this.createdAt,
    this.appointmentDate,
    this.user,
    this.report,
    this.address,
    this.type,
  });

  factory AppointmentResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return AppointmentResponse._(
      uid: snapshot.id,
      name: json?['name'],
      testId: json?['test_id'],
      price: json?['price'],
      status: json?['status'],
      appointmentDate: json?['date'],
      createdAt: json?['created_at'],
      user: json?['user'],
      report: json?['report'],
      address: json?['address'],
      type: json?['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'test_id': testId,
      'price': price,
      'status': status,
      'date': appointmentDate,
      'created_at': createdAt,
      'user': user,
      'report': report,
      'address': address,
      'type': type,
    };
  }

  HiveAppointment get toHive {
    return HiveAppointment()
      ..uid = uid
      ..name = name
      ..testId = testId
      ..price = price
      ..status = status
      ..appointmentDate = appointmentDate
      ..createdAt = createdAt?.toDate().toIso8601String()
      ..user = user
      ..report = report
      ..address = address
      ..type = type;
  }

  @override
  String toString() => jsonEncode(toJson());
}
