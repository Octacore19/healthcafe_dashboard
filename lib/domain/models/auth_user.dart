import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/local/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/gender.dart';
import 'package:intl/intl.dart';

class AuthUser extends Equatable {
  AuthUser._({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.emailVerified,
    required this.gender,
    required this.phoneVerified,
    required this.disabled,
    required this.profilePicture,
    required this.dateCreated,
    required this.lastLoginTime,
  }) {
    final nameSplit = name.split(' ');
    firstName = nameSplit.firstOrNull ?? '';
    lastName = nameSplit.length > 1 ? nameSplit[1] : '';
    if (lastLoginTime != null) {
      final activeDifference = DateTime.now().difference(lastLoginTime!);
      isActive = activeDifference.inDays < 60;
    } else {
      isActive = false;
    }
  }

  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime? dob;
  final bool emailVerified;
  final Gender gender;
  final bool phoneVerified;
  final bool disabled;
  final String profilePicture;
  final DateTime? dateCreated;
  final DateTime? lastLoginTime;

  late final String firstName;
  late final String lastName;
  late final bool isActive;

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
      phoneVerified: false,
      profilePicture: '',
      dateCreated: null,
      lastLoginTime: null,
    );
  }

  factory AuthUser.fromResponse(UserResponse? res) {
    final genderIndex = res?.gender ?? 2;
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final creation = res?.creationTime;
    final loginTime = res?.lastSignInTime;
    return AuthUser._(
      id: res?.uid ?? '',
      name: res?.displayName ?? 'Admin',
      email: res?.email ?? '',
      phone: res?.phoneNumber ?? '',
      dob: DateTime.tryParse(res?.dob ?? ''),
      emailVerified: res?.emailVerified ?? false,
      gender: Gender.values.firstWhere(
        (e) => e.genderIndex == genderIndex,
        orElse: () => Gender.unknown,
      ),
      phoneVerified: res?.phoneVerified ?? false,
      disabled: res?.disabled ?? false,
      profilePicture: res?.profilePicture ?? '',
      dateCreated: creation == null ? null : formatter.parseUTC(creation),
      lastLoginTime: loginTime == null ? null : formatter.parseUTC(loginTime),
    );
  }

  factory AuthUser.fromHive(HiveUser? user) {
    final genderIndex = user?.gender ?? 2;
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    final creation = user?.creationTime;
    final loginTime = user?.lastSignInTime;
    return AuthUser._(
      id: user?.uid ?? '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      phone: user?.phoneNumber ?? '',
      dob: DateTime.tryParse(user?.dob ?? ''),
      emailVerified: user?.emailVerified ?? false,
      gender: Gender.values.firstWhere(
        (e) => e.genderIndex == genderIndex,
        orElse: () => Gender.unknown,
      ),
      phoneVerified: user?.phoneVerified ?? false,
      disabled: user?.disabled ?? false,
      profilePicture: user?.profilePicture ?? '',
      dateCreated: creation == null ? null : formatter.parseUTC(creation),
      lastLoginTime: loginTime == null ? null : formatter.parseUTC(loginTime),
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
        phoneVerified,
        disabled,
        profilePicture,
      ];
}
