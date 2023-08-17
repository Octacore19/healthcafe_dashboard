import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: userId, adapterName: 'UserAdapter')
class HiveUser extends HiveObject {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? displayName;

  @HiveField(2)
  String? dob;

  @HiveField(3)
  String? email;

  @HiveField(4)
  bool? emailVerified;

  @HiveField(5)
  int? gender;

  @HiveField(6)
  String? phoneNumber;

  @HiveField(7)
  bool? phoneVerified;

  @HiveField(8)
  bool? disabled;

  @HiveField(9)
  String? lastSignInTime;

  @HiveField(10)
  String? creationTime;

  @HiveField(11)
  String? profilePicture;
}