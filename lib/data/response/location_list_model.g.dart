// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationListModelAdapter extends TypeAdapter<LocationListModel> {
  @override
  final int typeId = 0;

  @override
  LocationListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationListModel(
      locationList: (fields[0] as List?)?.cast<LocationDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.locationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationDataModelAdapter extends TypeAdapter<LocationDataModel> {
  @override
  final int typeId = 1;

  @override
  LocationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationDataModel(
      longitude: fields[0] as String?,
      latitude: fields[1] as String?,
      locationName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.longitude)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.locationName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
