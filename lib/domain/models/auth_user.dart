import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:healthcafe_dashboard/data/remote/models/user_response.dart';
import 'package:healthcafe_dashboard/domain/models/gender.dart';

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
  }) {
    final nameSplit = name.split(' ');
    firstName = nameSplit.firstOrNull ?? '';
    lastName = nameSplit.length > 1 ? nameSplit[1] : '';
  }

  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime dob;
  final bool emailVerified;
  final Gender gender;
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
      phoneVerified: false,
      profilePicture: '',
    );
  }

  factory AuthUser.fromResponse(UserResponse? res) {
    final genderIndex = res?.gender ?? 2;
    return AuthUser._(
      id: res?.uid ?? '',
      name: res?.displayName ?? 'Admin',
      email: res?.email ?? '',
      phone: res?.phoneNumber ?? '',
      dob: DateTime.tryParse(res?.dob ?? '') ?? DateTime.now(),
      emailVerified: res?.emailVerified ?? false,
      gender: Gender.values.firstWhere(
        (e) => e.genderIndex == genderIndex,
        orElse: () => Gender.unknown,
      ),
      phoneVerified: res?.phoneVerified ?? false,
      disabled: res?.disabled ?? false,
      profilePicture: res?.profilePicture ?? '',
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
