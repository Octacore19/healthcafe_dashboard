import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponse {
  UserResponse._({
    this.displayName,
    this.dob,
    this.email,
    this.emailVerified,
    this.gender,
    this.lastSignInTime,
    this.phoneNumber,
    this.phoneVerified,
    this.uid,
    this.disabled,
    this.creationTime,
    this.profilePicture,
  });

  final String? displayName;
  final String? dob;
  final String? email;
  final bool? emailVerified;
  final int? gender;
  final String? phoneNumber;
  final bool? phoneVerified;
  final String? uid;
  final bool? disabled;
  final String? lastSignInTime;
  final String? creationTime;
  final String? profilePicture;

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
      'phone_number': phoneNumber,
      'phone_verified': phoneVerified,
      'disabled': disabled,
      'creation_time': creationTime,
      'profile_picture': profilePicture,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
