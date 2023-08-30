import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/gender.dart';
import 'package:intl/intl.dart';

class AuthUser extends Equatable {
  AuthUser._({
    required this.name,
    required this.email,
    required this.id,
    required this.phone,
    required this.disabled,
    required this.phoneVerified,
    required this.onboardedTest,
    required this.gender,
    required this.emailVerified,
    required this.dob,
    required this.onboardScore,
    required this.profilePicture,
    this.creationDate,
  }) {
    final nameSplit = name.split(' ');
    firstName = nameSplit.firstOrNull ?? '';
    lastName = nameSplit.length > 1 ? nameSplit[1] : '';
  }

  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime? dob;
  final DateTime? creationDate;
  final bool emailVerified;
  final Gender gender;
  final double onboardScore;
  final bool onboardedTest;
  final bool phoneVerified;
  final bool disabled;
  final String profilePicture;

  late final String firstName;
  late final String lastName;

  factory AuthUser.empty() {
    return AuthUser._(
      name: '',
      email: '',
      id: '',
      phone: '',
      disabled: false,
      dob: DateTime.now(),
      emailVerified: false,
      gender: Gender.unknown,
      onboardedTest: false,
      phoneVerified: false,
      onboardScore: 0.0,
      profilePicture: '',
    );
  }

  factory AuthUser.fromHive(HiveUser? user) {
    final genderIndex = user?.gender ?? 2;
    return AuthUser._(
      id: user?.uid ?? '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      phone: user?.phoneNumber ?? '',
      dob: user?.dob == null ? null : DateTime.tryParse(user!.dob!),
      creationDate: user?.creationTime == null
          ? null
          : DateTime.tryParse(user!.creationTime!),
      emailVerified: user?.emailVerified ?? false,
      gender: Gender.values.firstWhere(
        (e) => e.genderIndex == genderIndex,
        orElse: () => Gender.unknown,
      ),
      phoneVerified: user?.phoneVerified ?? false,
      disabled: user?.disabled ?? false,
      profilePicture: user?.profilePicture ?? '',
      onboardedTest: user?.onboarded ?? false,
      onboardScore: user?.onboardingScore != null
          ? double.tryParse(user!.onboardingScore!) ?? 0.0
          : 0.0,
    );
  }

  bool get isEmpty => id.isEmpty || this == AuthUser.empty();

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        dob,
        emailVerified,
        gender,
        onboardedTest,
        phoneVerified,
        disabled,
        onboardScore,
        profilePicture,
      ];
}
