import 'dart:convert';

import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/base_model.dart';
import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: appointmentId, adapterName: 'AppointmentAdapter')
class HiveAppointment extends HiveObject with BaseModel {
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

  @HiveField(7)
  String? address;

  @HiveField(8)
  String? report;

  @HiveField(9)
  int? type;

  @HiveField(10)
  String? user;

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'price': price,
      'appointmentDate': appointmentDate,
      'createdAt': createdAt,
      'status': status,
      'testId': testId,
      'address': address,
      'report': report,
      'type': type,
      'user': user,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}