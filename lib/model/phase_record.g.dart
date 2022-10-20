// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhasesRecordsAdapter extends TypeAdapter<PhasesRecords> {
  @override
  final int typeId = 2;

  @override
  PhasesRecords read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhasesRecords(
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PhasesRecords obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhasesRecordsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
