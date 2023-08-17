import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/appointment.dart';

class AppointmentResponse {
  final String? uid;
  final String? name;
  final String? testId;
  final int? status;
  final int? price;
  final String? createdAt;
  final String? appointmentDate;

  AppointmentResponse._({
    this.uid,
    this.name,
    this.testId,
    this.status,
    this.price,
    this.createdAt,
    this.appointmentDate,
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
      status: json?['payment_status'],
      appointmentDate: json?['transaction_date'],
      createdAt: json?['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'test_id': testId,
      'price': price,
      'payment_status': status,
      'transaction_date': appointmentDate,
      'created_at': createdAt,
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
      ..createdAt = createdAt;
  }

  @override
  String toString() => jsonEncode(toJson());
}
