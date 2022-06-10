// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceHistoryListModelAdapter
    extends TypeAdapter<AttendanceHistoryListModel> {
  @override
  final int typeId = 2;

  @override
  AttendanceHistoryListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceHistoryListModel(
      history: (fields[0] as List?)?.cast<HistoryListData>(),
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceHistoryListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceHistoryListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryListDataAdapter extends TypeAdapter<HistoryListData> {
  @override
  final int typeId = 3;

  @override
  HistoryListData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryListData(
      locationData: fields[0] as LocationDataModel?,
      time: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryListData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.locationData)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryListDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
