import 'dart:convert';

import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/base_model.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: userId, adapterName: 'UserAdapter')
class HiveUser extends HiveObject with BaseModel {
  @HiveField(0)
  dynamic uid;

  @HiveField(1)
  String? displayName;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phoneNumber;

  @HiveField(4)
  String? dob;

  @HiveField(5)
  bool? emailVerified;

  @HiveField(6)
  int? gender;

  @HiveField(7)
  String? onboardingScore;

  @HiveField(8)
  bool? onboarded;

  @HiveField(9)
  bool? phoneVerified;

  @HiveField(10)
  bool? disabled;

  @HiveField(11)
  String? profilePicture;

  @HiveField(12)
  String? creationTime;

  @HiveField(13)
  String? lastSignInTime;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': displayName,
      'phone': phoneNumber,
      'dob': dob,
      'emailVerified': emailVerified,
      'gender': gender,
      'onboardScore': onboardingScore,
      'onboarded': onboarded,
      'phoneVerified': phoneVerified,
      'disabled': disabled,
      'profilePicture': profilePicture,
      'creationTime': creationTime,
      'lastSignInTime': lastSignInTime,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}