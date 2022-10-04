// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaintenanceRecordAdapter extends TypeAdapter<MaintenanceRecord> {
  @override
  final int typeId = 0;

  @override
  MaintenanceRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaintenanceRecord(
      phase: fields[0] as String?,
      sector: fields[1] as String?,
      category: fields[2] as String?,
      complainType: fields[3] as String?,
      status: fields[4] as String,
      remarks: fields[5] as String?,
      createdAt: fields[6] as String?,
      imageBefore1: fields[7] as String?,
      imageBefore2: fields[8] as String?,
      imageAfter1: fields[9] as String?,
      imageAfter2: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MaintenanceRecord obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.phase)
      ..writeByte(1)
      ..write(obj.sector)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.complainType)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.remarks)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.imageBefore1)
      ..writeByte(8)
      ..write(obj.imageBefore2)
      ..writeByte(9)
      ..write(obj.imageAfter1)
      ..writeByte(10)
      ..write(obj.imageAfter2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaintenanceRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
