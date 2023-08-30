import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';

class UserResponse {
  UserResponse._({
    this.displayName,
    this.dob,
    this.email,
    this.emailVerified,
    this.gender,
    this.lastSignInTime,
    this.onboardingScore,
    this.onboarded,
    this.phoneNumber,
    this.phoneVerified,
    this.uid,
    this.disabled,
    this.creationTime,
    this.profilePicture,
  });

  final String? uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final String? onboardingScore;
  final int? gender;
  final Timestamp? dob;
  final Timestamp? creationTime;
  final Timestamp? lastSignInTime;
  final bool? emailVerified;
  final bool? onboarded;
  final bool? phoneVerified;
  final bool? disabled;

  factory UserResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return UserResponse._(
      uid: json?['uid'],
      displayName: json?['display_name'],
      dob: json?['dob'],
      email: json?['email'],
      emailVerified: json?['email_verified'],
      gender: json?['gender'],
      lastSignInTime: json?['last_sign_in_time'],
      onboardingScore: json?['onboarding_score'],
      onboarded: json?['onboarding_test'],
      phoneNumber: json?['phone_number'],
      phoneVerified: json?['phone_verified'],
      disabled: json?['disabled'],
      creationTime: json?['creation_time'],
      profilePicture: json?['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'display_name': displayName,
      'dob': dob,
      'email': email,
      'email_verified': emailVerified,
      'gender': gender,
      'last_sign_in_time': lastSignInTime,
      'onboarding_score': onboardingScore,
      'onboarding_test': onboarded,
      'phone_number': phoneNumber,
      'phone_verified': phoneVerified,
      'disabled': disabled,
      'creation_time': creationTime,
      'profile_picture': profilePicture,
    };
  }

  HiveUser get toHive {
    return HiveUser()
      ..uid = uid
      ..displayName = displayName
      ..dob = dob?.toDate().toIso8601String()
      ..email = email
      ..emailVerified = emailVerified
      ..gender = gender
      ..lastSignInTime = lastSignInTime?.toDate().toIso8601String()
      ..onboardingScore = onboardingScore
      ..onboarded = onboarded
      ..phoneNumber = phoneNumber
      ..phoneVerified = phoneVerified
      ..disabled = disabled
      ..creationTime = creationTime?.toDate().toIso8601String()
      ..profilePicture = profilePicture;
  }
}
