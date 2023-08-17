// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<HiveUser> {
  @override
  final int typeId = 100;

  @override
  HiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUser()
      ..uid = fields[0] as String?
      ..displayName = fields[1] as String?
      ..dob = fields[2] as String?
      ..email = fields[3] as String?
      ..emailVerified = fields[4] as bool?
      ..gender = fields[5] as int?
      ..phoneNumber = fields[6] as String?
      ..phoneVerified = fields[7] as bool?
      ..disabled = fields[8] as bool?
      ..lastSignInTime = fields[9] as String?
      ..creationTime = fields[10] as String?
      ..profilePicture = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.emailVerified)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.phoneVerified)
      ..writeByte(8)
      ..write(obj.disabled)
      ..writeByte(9)
      ..write(obj.lastSignInTime)
      ..writeByte(10)
      ..write(obj.creationTime)
      ..writeByte(11)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
