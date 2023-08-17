// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentAdapter extends TypeAdapter<HiveAppointment> {
  @override
  final int typeId = 101;

  @override
  HiveAppointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAppointment()
      ..uid = fields[0] as String?
      ..name = fields[1] as String?
      ..price = fields[2] as int?
      ..appointmentDate = fields[3] as String?
      ..createdAt = fields[4] as String?
      ..status = fields[5] as int?
      ..testId = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, HiveAppointment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.appointmentDate)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.testId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
